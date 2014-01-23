define ['ember','cs!unlockable/unlockable','cs!dropblocks/views', 'cs!dropblocks/models', 'cs!dropblocks/controllers' ],(Em, Unlockable, Views, Models, Controllers) ->
    for key of Controllers
        Unlockable[key] = Controllers[key]
    for key of Views
        Unlockable[key] = Views[key]

    return {
        parseGame: (gameData) ->
            dropblocks = Models.Dropblocks.create
                id: gameData.id
                video: gameData.commercial.video
                logo: gameData.commercial.brand_image

            return dropblocks


        DropblocksRoute : Em.Route.extend
            connectOutlets: (router, context) ->
                router.dropblocksController.set('timer-display', 'no-timer')
                router.get('gameController').connectOutlet('dropblocks')
                router.dropblocksController.set('timer-display', "no-timer")
                router.dropblocksController.endTimer()


            timerFinished: (router) ->
                #pass


            start: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.dropblocksController.connectOutlet('dropblocksInstructions')

                watchCommercial: (router, context) ->
                    router.transitionTo('game')

            game: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.dropblocksController.set('timer-display', "timer")
                    router.dropblocksController.connectOutlet('dropblocksRound')
                    Em.run.next router.dropblocksController, 'startTimer', () ->
                        router.send('timerFinished')

                commercialFinished: (router, context) ->
                    router.transitionTo('performance')


            performance: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.dropblocksController.endTimer()
                    router.dropblocksController.set('timer-display', "no-timer")
                    score  = router.get('dropblocksController.score')
                    current_points = router.get('currentPlayerController.points')
                    router.set('currentPlayerController.points', current_points + score)

                    router.dropblocksController.connectOutlet('dropblocksPerformance')

                    stars = router.get('dropblocksController.content.stars')
                    if stars == 2 or stars == 1
                        Unlockable.playGoodSound()
                    else
                        Unlockable.playGreatSound()


                likeAd: (router, context) ->
                    router.get('dropblocksController').set('redeemed', true)
                    Unlockable.likeAd(router.get('dropblocksController').get('content'))

    }
