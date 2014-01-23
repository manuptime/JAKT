define ['ember'
    '_'
    "./templates"
    ], (Em,
        _,
        templates) ->
    return {
        FooView: Em.View.extend
            templateName: ''

        FooInstructionsView: Em.View.extend
            templateName: "FooInstructions"

        FooCommercialView : Em.View.extend
            templateName: 'FooCommercial'

        FooPerformanceView: Em.View.extend
            templateName: "FooPerformance"

    }