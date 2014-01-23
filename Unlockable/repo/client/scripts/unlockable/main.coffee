 define ['jquery'
        'ember'
        '_'
        'cs!unlockable/unlockable'
        'cs!unlockable/preloader'
        'cs!unlockable/sound'
        'cs!trivia/trivia'
        'cs!frames/frames'
        'cs!puzzle/puzzle'
        'cs!dropblocks/dropblocks'
        "cs!frames/models_fixtures"
        "cs!trivia/models_fixtures"
        "cs!puzzle/models_fixtures"
        "cs!dropblocks/models_fixtures"
        "cs!unlockable/models_fixtures"
        ], ($, Em, _, Unlockable, Preloader, Sound, Trivia, Frames, Puzzle, Dropblocks, FramesFixtures, TriviaFixtures, PuzzleFixtures, DropblocksFixtures, UnlockableFixtures) ->

    GameTypes = "trivia":Trivia, "frames":Frames, "puzzle":Puzzle, "dropblocks":Dropblocks

    #todo - move these two functions into a utils module
    Unlockable.setupFixtures = (games = ['frames', 'trivia', 'puzzle', 'dropblocks'], data={frames:'verizonShareFrames', trivia:'mcdsFishTrivia', puzzle: 'oreoPuzzle', dropblocks: 'angelsoftDropblocks'}) ->
        #Em.Logger.log("something")

        if not Unlockable.useFixtures
            return

        Unlockable.router.set('currentPlayerController.content', UnlockableFixtures.makeData().testUser)
        trivias = TriviaFixtures.makeData()
        frames = FramesFixtures.makeData()
        puzzles = PuzzleFixtures.makeData()
        dropblockss = DropblocksFixtures.makeData()

        frameFixture = frames[data['frames']]
        triviaFixture = trivias[data['trivia']]
        puzzleFixture = puzzles[data['puzzle']]
        dropblocksFixture = dropblockss[data['dropblocks']]

        if "trivia" in games
            @Games['trivia'] = triviaFixture
        if "puzzle" in games
            @Games['puzzle'] = puzzleFixture

        if "frames" in games
            @Games['frames'] = frameFixture

        if "dropblocks" in games
            @Games['dropblocks'] = dropblocksFixture

        Unlockable.router.set('triviaController.content', triviaFixture)
        Unlockable.router.set('framesController.content', frameFixture)
        Unlockable.router.set('puzzleController.content', puzzleFixture)
        Unlockable.router.set('dropblocksController.content', dropblocksFixture)

        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().georgeFrames)
        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().subwayFrames)
        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().hundaiFrames)
        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().doritosFashionistaFrames)
        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().oldSpiceFrames)
        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().miracleWhipFrames)
        #Unlockable.router.set('framesController.content', FramesFixtures.makeData().stateFarmFrames)

        #Unlockable.router.set('triviaController.content', TriviaFixtures.makeData().amexTrivia)
        #Unlockable.router.set('triviaController.content', TriviaFixtures.makeData().oreoTrivia)
        #Unlockable.router.set('triviaController.content', TriviaFixtures.makeData().reebokTrivia)
        #Unlockable.router.set('triviaController.content', TriviaFixtures.makeData().mcdsFishTrivia)

        for frame in frameFixture.get('frames')
            Unlockable.preloader.loadFile(frame.get('imagePath'))

        for src in frameFixture.get('sources')
            Unlockable.preloader.loadFile(src)

        for src in triviaFixture.get('sources')
            Unlockable.preloader.loadFile(src)

        for src in puzzleFixture.get('sources')
            Unlockable.preloader.loadFile(src)

        if dropblocksFixture
            for src in dropblocksFixture.get('sources')
                Unlockable.preloader.loadFile(src)

        Unlockable.router.send('weHaveInventory')

    Unlockable.parseGames = (games) ->
        for gameType, gameData of games
            if gameData?
                gameModel = GameTypes[gameType].parseGame(gameData)
                #hack for breaking puzzle on windows
                if  navigator.userAgent.search("Chrome") > 0 and navigator.platform.find("Win") > 0
                    if gameType == "puzzle" or gameType == "dropblocks"
                        continue
                Unlockable.Games[gameType] = gameModel






    Unlockable.Router =  Em.Router.extend
        enableLogging: Unlockable.debug

        nextGame: (router) ->
            current_points = router.get('currentPlayerController.points')
            loadedGames = _.keys(Unlockable.Games)
            if current_points >= Unlockable.pointsNeeded or loadedGames.length == 0
                router.transitionTo('goodbye')
            else
                chosenGame = _.shuffle(loadedGames).pop()
                #chosenGame = loadedGames.pop()
                gameModel = Unlockable.Games[chosenGame]
                delete Unlockable.Games[chosenGame]
                router.set(chosenGame + "Controller.content", gameModel)
                router.transitionTo(chosenGame)
                gameModel.timestarted = (new Date()).toUTCString()
                Unlockable.startGame(gameModel)

                if _.keys(Unlockable.Games).length == 0 and not Unlockable.useFixtures
                    Unlockable.getMoreGames()


        root: Em.Route.extend

            start: Em.Route.extend(
                noRecord: true
                )
            boot: Em.Route.extend
                noRecord: true
                connectOutlets: (router, context) ->
                    if not Unlockable.useFixtures
                        Unlockable.setupLocalData()
                        Unlockable.getInitialData()

                weHaveInventory: (router, context) ->
                    #router.transitionTo('readyToStart')
                    Unlockable.inventoryCallback(true)

                noInventory: (router, context) ->
                    Unlockable.inventoryCallback(false)
                    router.transitionTo('noContent')

            readyToStart: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.get('applicationController').connectOutlet('readyToStart')

                startUnlockable: (router, context) ->
                    router.transitionTo('unlockable')

            unlockable: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.get('applicationController').connectOutlet('unlockable')

                howItWorks: Em.Route.extend
                    connectOutlets: (router, context) ->
                        router.get('unlockableController').connectOutlet('howItWorks')
                    back: (router, context) ->
                        router.transitionTo('start')


                start: Em.Route.extend
                    showCustomerServiceButton: true
                    customerService: (router, context) ->
                        router.transitionTo('howItWorks')

                    connectOutlets: (router, context) ->
                        Unlockable.recordModelOpen()
                        router.get('unlockableController').connectOutlet('welcome')
                        Unlockable.playGreatSound()
                        $("body").addClass('unlockable-fixed-position')
                        $("#unlockable-main").addClass('active')

                    startGame: (router, context) ->
                        Unlockable.playGoodSound()
                        router.transitionTo('games')
                    howItWorks: (router, context) ->
                        router.transitionTo('howItWorks')
                    error: (router, context) ->
                        router.transitionTo('error')


                games: Em.Route.extend
                    connectOutlets: (router, context) ->
                        router.get('unlockableController').connectOutlet('game')

                    start: Em.Route.extend
                        noRecord: true

                        connectOutlets: (router, context) ->
                            router.nextGame(router)

                    trivia: Trivia.TriviaRoute

                    frames: Frames.FramesRoute

                    puzzle: Puzzle.PuzzleRoute

                    dropblocks: Dropblocks.DropblocksRoute

                    doneWithGame: (router, context) ->
                        performace = router.currentState
                        gameState = performace.parentState
                        currentGame = router.get(gameState.name + "Controller").content
                        Unlockable.finishGame(currentGame)
                        router.nextGame(router)

                goodbye: Em.Route.extend
                    hideCloseButton: false
                    connectOutlets: (router, context) ->
                        currentPlayer = router.currentPlayerController.get('content')
                        if currentPlayer.get('takenSurvey')
                            router.get('unlockableController').connectOutlet('survey')
                        else
                            router.get('unlockableController').connectOutlet('goodbye')

                        Unlockable.playGreatSound()
                        #Unlockable.startMusic()
                        currentPlayer = Unlockable.router.currentPlayerController.get('content')
                        payload = currentPlayer.getProperties()

                        $.ajax
                            type: "POST",
                            url: "#{ Unlockable.host }/beta/unlock/"
                            data: JSON.stringify(payload)
                            #contentType: "application/json; charset=utf-8"
                            dataType: "json"
                            success: (data) ->
                                2
                            failure: (errMsg) ->
                                2
                    stopUnlockable: (router, context) ->
                        Unlockable.stopMusic()
                        $("body").removeClass('unlockable-fixed-position')
                        $("#unlockable-main").removeClass('active')
                        router.transitionTo('readyToStart')
                        currentPoints = Unlockable.router.currentPlayerController.get('content.points')
                        window.finishedUnlockable(currentPoints)

            doQuit: (router, context) ->
                quit = confirm("If you exit, you'll lose your progress.")
                if quit
                    Unlockable.stopMusic()
                    router.transitionTo('readyToStart')
                    $("body").removeClass('unlockable-fixed-position')
                    $("#unlockable-main").removeClass('active')

            mute: (router, context) ->
                Unlockable.toggleMute()

            error: Em.Route.extend
                connectOutlets: (router, context) ->
                    router.get('unlockableController').connectOutlet('error')

                reportError: (router, context) ->
                    Unlockable.createAnalyticEvent("error_report", {})
                    router.get('errorController').set('submitted', true)


        noContent: Em.Route.extend
            noRecord: true
            unlockable: Em.Route.extend
                noRecord: true
        location: 'none'
