define ['_', 'ember', 'cs!unlockable/models',], (_, Em, UnlockableModels) ->

    AnswerAttempt =  Em.Object.extend
        question: null
        answer: null
        isCorrect: (()->
            return @get('answer.isCorrect')
        ).property('answer.correctAnswer').cacheable('answer.correctAnswer')


    return {
        AnswerAttempt:AnswerAttempt

        Question : Em.Object.extend
            game: null
            questionText : null #the actual text of the question
            answers : null
            correctAnswer : null

            init: (question, correctAnswer, wrongAnswers...) ->
                @set('answers', [])
                @_super();

            addAnswers: (answers...) -> # one or more same obj arg comma sep
                answers = (answer for answer in answers when answer?)
                @get('answers').pushObjects(answers)
                (answer.set('question', this) for answer in answers)  # question attr created and set
                if not @get('correctAnswer')
                    @set('correctAnswer', answers[0])

            displayAnswers: (() ->
                return _.shuffle(@get('answers'))
            ).property('answers')

            removeAnswer: (answer) ->
                _idx = @get('answers').indexOf(answer)
                if _idx is -1
                    return false
                @get('answers').removeAt(_idx)
                answer.set('question', null)
                return true

            toString: () ->
               return @get('questionText')

        Answer: Em.Object.extend
            question : null
            answer: null

            toString: ->
                return @get('answer')

            isCorrect: ( ->
                question = @get('question')
                if not question?
                    raise "answer not attatched to question"
                if question.get('correctAnswer') is @
                    return true
                else
                    return false
                ).property('question.correctAnswer').cacheable('question.correctAnswer')


        Trivia : UnlockableModels.Game.extend
            questions : null
            commercial : null
            _answerAttemps: null
            init: () ->
                @_super();
                @set('questions', [])
                @set('_answerAttempts', [])

            addQuestions: (questions...) ->
                questions = (question for question in questions when question?)
                @get('questions').pushObjects(questions)
                question.set('game', this) for question in questions

            removeQuestion: (question) ->
                _idx = @get('questions').indexOf(question)
                if _idx is -1
                    return false
                @get('questions').removeAt(_idx)
                question.set('game', null)
                return true

            addAttempts: (attempts...) ->
                attempts = (attempt for attempt in attempts when attempt?)
                @get('_answerAttempts').pushObjects(attempts)

            answerAttempts: (()->
                attempts = @get('_answerAttempts')
                a = attempts.slice(0)  # weak copy
                q = @get('questions').length
                while a.length < q
                    a.push(AnswerAttempt.create())
                return a
            ).property('_answerAttempts.@each')

            answersRight: (() ->
                return (attempt for attempt in @_answerAttempts when attempt.answer.get('isCorrect')).length #isCorrect false will fail guard clause
            ).property('_answerAttempts.@each') # @each notice operations on array elements not just array

            correctChoices: (() ->
                return @get('answersRight')
            ).property('answersRight')

            gameActionsRating: (() ->
                return @get('questions').length
            ).property('questions')

            earnedAccuracyBounus: (() ->
                return @get('answersRight') == @get('questions').length
            ).property('answersRight', 'questions')

            timeBuffer: 15
    }
