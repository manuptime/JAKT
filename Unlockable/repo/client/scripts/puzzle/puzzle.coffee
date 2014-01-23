define ['ember','cs!unlockable/unlockable','cs!puzzle/views', 'cs!puzzle/models', 'cs!puzzle/controllers' ],(Em, Unlockable, Views, Models, Controllers) ->
    for key of Controllers
        Unlockable[key] = Controllers[key]
    for key of Views
        Unlockable[key] = Views[key]

    return {
        parseGame: (gameData) ->
            puzzle = Models.Puzzle.create
                id: gameData.id
                video: gameData.commercial.video
                logo: gameData.commercial.brand_image

            return puzzle


        PuzzleRoute : Em.Route.extend
            connectOutlets: (router, context) ->
                router.puzzleController.set('timer-display', 'no-timer')
                router.get('gameController').connectOutlet('puzzle')
                router.puzzleController.set('timer-display', "no-timer")
                router.puzzleController.endTimer()


            timerFinished: (router) ->
                #pass


            start: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.puzzleController.connectOutlet('puzzleInstructions')

                watchCommercial: (router, context) ->
                    router.transitionTo('game')

            game: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.puzzleController.set('timer-display', "timer")
                    router.puzzleController.connectOutlet('puzzleRound')
                    Em.run.next router.puzzleController, 'startTimer', () ->
                        router.send('timerFinished')

                commercialFinished: (router, context) ->
                    router.transitionTo('performance')


            performance: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.puzzleController.endTimer()
                    router.puzzleController.set('timer-display', "no-timer")
                    score  = router.get('puzzleController.score')
                    current_points = router.get('currentPlayerController.points')
                    router.set('currentPlayerController.points', current_points + score)

                    router.puzzleController.connectOutlet('puzzlePerformance')

                    stars = router.get('puzzleController.content.stars')
                    if stars == 2 or stars == 1
                        Unlockable.playGoodSound()
                    else
                        Unlockable.playGreatSound()


                likeAd: (router, context) ->
                    router.get('puzzleController').set('redeemed', true)
                    Unlockable.likeAd(router.get('puzzleController').get('content'))

    }
