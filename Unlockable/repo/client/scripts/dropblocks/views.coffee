define ['ember'
    '_'
    'cs!unlockable/views'
    "dropblocks/templates"
     "dropblocks/dropblocksAll"
    ], (Em,
        _,
        UnlockableViews,
        templates,
        Dropblocks,
        ) ->
    return {
        DropblocksView: Em.View.extend
            templateName: 'Dropblocks'

        DropblocksInstructionsView: Em.View.extend
            templateName: "DropblocksInstructions"

        DropblocksRoundView : Em.View.extend
            templateName: 'DropblocksRound'
            classNames: ['dropblocks-game-screen', 'unlockable-screen']
            didInsertElement: () ->
                video = this.$('#unlockable-commercial')[0]

                #console.log('Dropblocks dropblocksAll')
                #console.log(Dropblocks)

                Dropblocks.startGame(video, this)
                #console.log(DropblocksXXX.test)

            #the user has won the game - huzza!
            wonGame: () ->
                this.$('video').show()
                this.$('canvas').hide()
                dropblocksController = Unlockable.router.get('dropblocksController')
                dropblocksController.endTimer()
                dropblocksController.set('timer-display', "no-timer")

            connected: () ->
                this.incrementProperty('controller.content.connected')


        DropblocksVideoView: UnlockableViews.CommercialView.extend
            templateName: 'DropblocksVideo'

            didInsertElement: () ->
                # don't want to auto play, or show the commercial.
                this.$().hide()
                this.$().on('ended', $.proxy(this.ended, this))

        DropblocksGameView: Em.View.extend
            templateName: 'DropblocksGame'

        DropblocksPerformanceView: Em.View.extend
            templateName: "DropblocksPerformance"

    }