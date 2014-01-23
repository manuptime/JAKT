define ['ember','cs!unlockable/unlockable', 'cs!trivia/views', 'cs!trivia/models', 'cs!trivia/controllers'],(Em, Unlockable, Views, Models, Controllers) ->
    {AnswerAttempt} = Models
    for key of Models
        Unlockable[key] = Models[key]
    for key of Controllers
        Unlockable[key] = Controllers[key]
    for key of Views
        Unlockable[key] = Views[key]


    return {
        parseGame: (gameData) ->
            trivia = Models.Trivia.create
                id: gameData.id
                video: gameData.commercial.video
                logo: gameData.commercial.brand_image

            for question in gameData.questions
                q = Models.Question.create
                    id: question.id
                    questionText: question.question

                for answer in  question.answers
                    a = Models.Answer.create
                        answer: answer.answer
                        correct: answer.correct
                        id: answer.id
                    q.addAnswers(a)

                trivia.addQuestions(q)
            return trivia


        TriviaRoute :  Em.Route.extend
            likeAd: (router, context) ->
                    router.get('triviaController').set('redeemed', true)
                    Unlockable.likeAd(router.get('triviaController').get('content'))

            timerFinished: (router)->
                #router.transitionTo('performance')

            connectOutlets: (router, context) ->
                router.triviaController.set('timer-display', "no-timer")
                router.get('gameController').connectOutlet('trivia')

            start: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.triviaController.connectOutlet('triviaInstructions')
                    router.questionsController.set('questionIdx', 0)
                    router.triviaController.set('timer-display', "no-timer")
                    router.triviaController.endTimer()

                watchCommercial: (router, context) ->
                    router.transitionTo('commercial')

            commercial: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.triviaController.connectOutlet('triviaCommercial')

                commercialFinished: (router, context) ->
                    router.transitionTo('game')

            performance: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.triviaController.endTimer()
                    router.triviaController.set('timer-display', "no-timer")
                    score = router.get('triviaController.score')
                    current_points = router.get('currentPlayerController.points')
                    router.set('currentPlayerController.points', current_points + score)

                    router.triviaController.connectOutlet('performance')
                    stars = router.get('triviaController.content.stars')
                    if stars == 2 or stars == 1
                        Unlockable.playGoodSound()
                    else
                        Unlockable.playGreatSound()

            game: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.get('triviaController').connectOutlet('questions')

                #TODO: Figure how to get rid of this state and do this via variable
                start: Em.Route.extend
                    redirectsTo: 'question'

                question: Em.Route.extend
                    connectOutlets: (router, context) ->
                        router.get('questionsController').connectOutlet('activeQuestion')

                        if router.triviaController.get('timer') > 0
                           router.triviaController.set('timer-display', "timer")
                        else
                           router.triviaController.set('timer-display', "no-timer")

                        Em.run.next router.triviaController, 'startTimer', () ->
                            router.send('timerFinished')

                    questionAnswered: (router, event) ->
                        answer = event.context
                        isCorrect = answer.get('isCorrect')
                        if isCorrect
                            Unlockable.playGoodSound()
                            router.currentPlayerController.addPoints(100)
                        else
                            Unlockable.playBadSound()

                        attempt = AnswerAttempt.create
                            answer: answer

                        #record the answer attempt
                        #this should probably be on the controller in it's own method
                        eventdata = {}
                        eventdata['question_id'] = answer.get('question.id')
                        eventdata['answer_id'] = answer.id
                        Unlockable.createAnalyticEvent("trivia_answer", eventdata)



                        router.get('triviaController').addAttempts(attempt)

                        router.get('activeAnswerController').set('content', answer)
                        router.transitionTo('answered')

                answered: Em.Route.extend
                    controller: Controllers.activeQuestionController

                    connectOutlets: (router) ->
                        router.get('questionsController').connectOutlet('activeAnswer')
                        router.triviaController.set('timer-display', "no-timer")
                        router.triviaController.endTimer()

                    confirmAnswer: (router, context) ->
                        questionsController = router.get('questionsController')
                        questionsController.nextQuestion()
                        if questionsController.get('doneWithQuestions')
                            router.transitionTo('performance')
                        else
                            router.transitionTo('question')

    }
