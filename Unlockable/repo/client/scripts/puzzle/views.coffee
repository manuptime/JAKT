define ['ember'
    '_'
    'cs!unlockable/views'
    "puzzle/templates"
    "puzzle/JPuzzle"

    ], (Em,
        _,
        UnlockableViews,
        templates,
        JPuzzle,
        ) ->
    return {
        PuzzleView: Em.View.extend
            templateName: 'Puzzle'

        PuzzleInstructionsView: Em.View.extend
            templateName: "PuzzleInstructions"

        PuzzleRoundView : Em.View.extend
            templateName: 'PuzzleRound'
            classNames: ['puzzle-game-screen', 'unlockable-screen']
            didInsertElement: () ->
                video = this.$('#unlockable-commercial')[0]
                JPuzzle.JPuzzle(video, this)

            willDestroyElement: () ->
                #populated via the jpuzzle call
                window.clearInterval(this.video_refresh_interval)

            #the user has won the game - huzza!
            wonGame: () ->
                this.$('video').show()
                this.$('canvas').hide()
                puzzleController = Unlockable.router.get('puzzleController')
                puzzleController.endTimer()
                puzzleController.set('timer-display', "no-timer")

            connected: () ->
                this.incrementProperty('controller.content.connected')


        PuzzleVideoView: UnlockableViews.CommercialView.extend
            templateName: 'PuzzleVideo'


            didInsertElement: () ->
                # don't want to auto play, or show the commercial.
                this.$().hide()
                this.$().on('ended', $.proxy(this.ended, this))

        PuzzleGameView: Em.View.extend
            templateName: 'PuzzleGame'

        PuzzlePerformanceView: Em.View.extend
            templateName: "PuzzlePerformance"

    }