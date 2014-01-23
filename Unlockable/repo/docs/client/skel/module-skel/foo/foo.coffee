define ['ember','cs!unlockable/unlockable','cs!./views', 'cs!./models', 'cs!./controllers'],(Em, Unlockable, Views, Models, Controllers) ->
    for key of Controllers
        Unlockable[key] = Controllers[key]
    for key of Views
        Unlockable[key] = Views[key]

    return {
        parseGame: (gameData) ->
            #turn json from the server into model instances

        FooRoute : Em.Route.extend
            connectOutlets: (router, context) ->
                router.get('gameController').connectOutlet('foo')

            timerFinished: (router)->
                #router.transitionTo('performance')

            start: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.connectOutlet('fooInstructions')

                watchCommercial: (router, context) ->
                    router.transitionTo('commercial')

            commercial: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.connectOutlet('fooCommercial')

                commercialFinished: (router, context) ->
                    router.transitionTo('game')

            game: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.get('fooController').connectOutlet('fooRound')
                    Em.run.next router.fooController, 'startTimer', () ->
                        router.send('timerFinished')

                next: (router, context) ->
                    router.transitionTo('performance')

            performance: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.framesController.endTimer()
                    router.framesController.connectOutlet('fooPerformance')

    }
