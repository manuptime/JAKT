define ['ember', 'cs!unlockable/controllers'],(Em, UnlockableControllers) ->

    QuestionsController =  Em.ArrayController.extend
        contentBinding: 'Unlockable.router.triviaController.questions'
        questionIdx: 0
        nextQuestion: ()->
            idx = @get('questionIdx')
            @set('questionIdx', idx+1)

        activeQuestion: (() ->
            if @get('doneWithQuestions')
                return null
            else
                idx = @get('questionIdx')
                questions = @get('content')
                return questions[idx]
        ).property('content', 'questionIdx')

        doneWithQuestions:(() ->
            questions = @get('content')
            if not questions
                return true
            else
                return questions.length <= @get('questionIdx')
        ).property('questionIdx', 'content')

    TriviaController = UnlockableControllers.GameController.extend
        content: null
        addAttempts: (attempts) ->
            @get('content').addAttempts(attempts)


    ActiveQuestionController = Em.ObjectController.extend
        contentBinding: 'Unlockable.router.questionsController.activeQuestion'

        answers: (()->
            return @get('content')?.get('answers')
            ).property('content')

        #answerAttemptsBinding: 'Unlockable.router.triviaController.answerAttempts'

    ActiveAnswerController = Em.ObjectController.extend()

    TriviaCommercialController = Em.ObjectController.extend
        contentBinding: "Unlockable.router.triviaController.sources"

    TriviaPerformanceController = Em.ObjectController.extend
        contentBinding: "Unlockable.router.triviaController"
        starClass: (() ->
            stars = @get('stars')
            return "star-performance-#{ stars }"
        ).property()



    return {
        QuestionsController: QuestionsController
        TriviaController: TriviaController
        ActiveQuestionController: ActiveQuestionController
        PerformanceController: TriviaPerformanceController
        TriviaCommercialController:TriviaCommercialController
        TriviaInstructionsController: Em.ObjectController.extend()
        ActiveAnswerController: ActiveAnswerController
    }