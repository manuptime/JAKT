define ['ember', 'cs!unlockable/unlockable','cs!frames/views', 'cs!frames/models', 'cs!frames/controllers'],(Em, Unlockable, Views, Models, Controllers) ->
    for key of Controllers
        Unlockable[key] = Controllers[key]
    for key of Views
        Unlockable[key] = Views[key]

    return {
        parseGame: (gameData) ->
            frames = []
            for frame in gameData.frames
                f = Models.Frame.create
                    imagePath: frame.image_path
                    order: frame.order
                frames.push(f)
                Unlockable.preloader.loadFile(Unlockable.cdn + "/" + frame.image_path)
            frameGame = Models.Frames.create
                frames: frames
                id: gameData.id
                video: gameData.commercial.video
                logo: gameData.commercial.brand_image
            return frameGame

        FramesRoute : Em.Route.extend

            connectOutlets: (router, context) ->
                router.framesController.set('timer-display', 'no-timer')
                router.get('gameController').connectOutlet('frames')

            timerFinished: (router)->
                #router.transitionTo('performance')

            start: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.connectOutlet('framesInstructions')
                    router.framesController.set('timer-display', "no-timer")
                    router.framesController.endTimer()


                watchCommercial: (router, context) ->
                    router.transitionTo('commercial')

            commercial: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.connectOutlet('framesCommercial')

                commercialFinished: (router, context) ->
                    router.transitionTo('game')

            game: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.set('timer-display', "timer")
                    router.get('framesController').connectOutlet('currentRound')
                    Em.run.next router.framesController, 'startTimer', () ->
                        router.send('timerFinished')

                next: (router, context) ->
                    #TODO: should be renamed validate
                    frames = router.get('framesController')
                    if not frames.get('hasPlaced')
                        return

                    frames.checkFrames()

                    if frames.isFinished()
                        Em.run.end()   #flush changes from the checkframes
                        if frames.get('currentRound') > 1
                            Unlockable.playGoodSound()
                        else
                            Unlockable.playGreatSound()
                        router.framesController.endTimer()
                        router.transitionTo('performance')
                    else
                        Unlockable.playBadSound()

            performance: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.set('timer-display', "no-timer")
                    score  = router.get('framesController.score')
                    current_points = router.get('currentPlayerController.points')
                    router.set('currentPlayerController.points', current_points + score)

                    router.framesController.endTimer()
                    router.framesController.connectOutlet('framesPerformance')

                likeAd: (router, context) ->
                    router.get('framesController').set('redeemed', true)
                    Unlockable.likeAd(router.get('framesController').get('content'))
    }
