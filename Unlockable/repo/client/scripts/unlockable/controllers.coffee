define ['ember', 'cs!unlockable/models'], (Em, Models) ->
    CurrentPlayerController = Em.ObjectController.extend
        addPoints: (points) ->
            this.get('content').addPoints(points)


    GameController = Em.ObjectController.extend
        startTimer: (finishedCallback) ->
            @set('callback', finishedCallback)
            callback = Em.run.later(@, 'timerTick', 1000)
            @set('timerCallback', callback)
            $('.timer-wrapper').removeClass('paused')

        pauseTimer: (finishedCallback) ->
            @set('callback', finishedCallback)
            @set('timerCallback', callback)
            $('.timer-wrapper').addClass('paused')

        timerTick: () ->
            if @get('timer') <= 0
                @set('timer-display', "no-timer")
                @get('callback')()
            else
                timer = @get('timer')
#                 time_buffer = @get('timeBuffer')
#                 @set('timer', timer - 0.100)

#                 #console.log("timer: " + timer + " bonus: " + bonus_points + " buffer: " + time_buffer)

#                 # While timer < 30 - time_buffer bonus is 10000
#                 if timer + time_buffer < Models.MaxTimeInSeconds
#                     time_constant = @get('timeConstant')
#                     bonus_points = "+" + Math.round(time_constant * timer)
#                     @set('bonusPoints', bonus_points)
#                 else
#                     @set('bonusPoints', '+10000')

#                 callback = Em.run.later(@, 'timerTick', 100)
                @set('timer', timer-1)
                callback = Em.run.later(@, 'timerTick', 1000)
                @set('timerCallback', callback)

        endTimer: ()->
            Em.run.cancel(@get('timerCallback'))


    ErrorController = Em.ObjectController.extend
        submitted: null


    return {
        CurrentPlayerController: CurrentPlayerController
        ReadyToStartController: Em.ObjectController.extend()
        WelcomeController: Em.ObjectController.extend()
        HowItWorksController: Em.ObjectController.extend()
        GameController: GameController
        UnlockableController: Em.ObjectController.extend()
        GoodbyeController: Em.ObjectController.extend()
        ErrorController: ErrorController
    }