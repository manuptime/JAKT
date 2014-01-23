define ['ember', "trivia/templates"], (Em) ->
    return {
        TriviaView: Em.View.extend
            templateName: 'Trivia'

        TriviaInstructionsView: Em.View.extend
            templateName: 'TriviaInstructions'

        TriviaCommercialView : Em.View.extend
            templateName: 'TriviaCommercial'

        QuestionsView: Em.View.extend
            templateName: "TriviaQuestions"

        ActiveQuestionView: Em.View.extend
            templateName: "ActiveQuestion"

        ActiveAnswerView: Em.View.extend
            templateName: "ActiveAnswer"

        PerformanceView: Em.View.extend
            templateName: "TriviaPerformance"

    }