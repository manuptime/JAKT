define ['ember', '_', 'cs!unlockable/controllers','cs!frames/models',  ],(Em, _, UnlockableControllers, Models) ->

    FramesController = UnlockableControllers.GameController.extend
        isCorrect: (() ->
            #are all the frames in the right place
            return _.all(@get('correctFrames'), Boolean)
        ).property("playFrames.@each.imagePath")
        isFinished: (() ->
            ## have we taken all the attempts we get, or is everything correct
            if @get('isCorrect') or (@get('currentRound') >= @get('maxAttempts'))
                return true
            return false
        )
        attempts: (() ->
            # if the attempt is used, then false, if unused true
            rv = []
            countdown = (num for num in [10..1])
            rv.push(false) for x in _.range(@get('currentRound'))
            rv.push(true) for x in _.range(@get('maxAttempts')-@get('currentRound'))
            return rv
        ).property("currentRound")
        hasPlaced: (() ->
            return _.all(frame.get('imagePath') for frame in @get('playFrames'), Boolean)
        ).property("playFrames.@each.imagePath")
        checkFrames: () ->
            # inspects the frames, keeps correct ones in the same place and locks them,
            # moves wrong ones back to their origin, increments round counter
            @incrementProperty('currentRound')

            playFrames = @get('playFrames')
            masterFrames = @get('frames')

            givenFrames = Em.copy(@get('givenFrames'))
            givenFrames = _.sortBy(givenFrames, 'order')

            mixedupFrames = Em.copy(@get('mixedupFrames'))
            mixedupFrames = _.sortBy(mixedupFrames, 'order')

            zipped = _.zip(masterFrames, playFrames, givenFrames, mixedupFrames)
            _.map zipped, (frameSet) ->
                [master, play, given, mixedup] = frameSet
                if not Em.isEqual(master, play)
                    play.set('imagePath', null)
                    given.set('imagePath', mixedup.get('imagePath'))
                else if Em.isEqual(master, play)
                    # incase they moved frame in the given set to another given, but matched
                    # the frame it came from correctly
                    given.set('imagePath', null)
                    play.set('locked', true)

    MixedupFramesMasterController =  Em.ArrayController.extend
        contentBinding: 'Unlockable.router.framesController.mixedupFrames'

    GivenFramesController = Em.ArrayController.extend
        contentBinding: 'Unlockable.router.framesController.givenFrames'

    PlayFramesController = Em.ArrayController.extend
        contentBinding: 'Unlockable.router.framesController.playFrames'

    FramesPerformanceController = Em.ObjectController.extend
        contentBinding: 'Unlockable.router.framesController'
        starClass: (() ->
            stars = @get('stars')
            return "star-performance-#{ stars }"
        ).property()

    FramesCommercialController = Em.ObjectController.extend
        contentBinding: "Unlockable.router.framesController.sources"


    return {
        FramesController: FramesController
        MixedupFramesMasterController: MixedupFramesMasterController
        GivenFramesController:GivenFramesController
        PlayFramesController:PlayFramesController
        FramesCommercialController:FramesCommercialController
        FramesPerformanceController:FramesPerformanceController
        FramesInstructionsController: Em.ObjectController.extend()
    }