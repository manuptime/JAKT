define ['ember', '_', 'cs!unlockable/models'],(Em, _, UnlockableModels) ->
    FRAMES_PER_GAME = 5
    ROUNDS_PER_GAME = 3

    Frames =  UnlockableModels.Game.extend
        init: () ->
            frames = @get('frames')

            #mixedupFrames = Em.copy(frames, true) #copy doesn't do deep yet
            mixedupFrames = (frame.clone() for frame in frames)
            mixedupFrames = _.shuffle(mixedupFrames)
            @set('mixedupFrames', mixedupFrames)

            @set('givenFrames', (frame.clone() for frame in mixedupFrames))

            emptyFrames = (Frame.create({order: x}) for x in [0..frames.length-1])
            @set('playFrames', emptyFrames)

            @_super();

        frames : null

        mixedupFrames: null
        playFrames: null
        givenFrames: null

        maxAttempts: ROUNDS_PER_GAME
        currentRound: 0

        addFrames: (frames...) ->
            frames = x for x in frames if x
            @get('frames').pushObjects(frames...)

        correctFrames: (() ->
            playFrames = @get('playFrames')
            masterFrames = @get('frames')
            zipped = _.zip(masterFrames, playFrames)
            return _.map zipped, (frameSet) ->
                return Em.isEqual(frameSet[0], frameSet[1])
        ).property("playFrames.@each.imagePath")

        correctChoices: (() ->
            #for points calculation
            frames = @get('correctFrames')
            len =  _.filter(frames, Boolean).length
            if len != frames.length
                return 0
            return Math.floor((@get('maxAttempts') + 1) - @get('currentRound'))
        ).property('maxAttempts', 'currentRound', 'correctFrames')

        gameActionsRating: (() ->
            return ROUNDS_PER_GAME
        ).property()

        earnedAccuracyBounus: (() ->
            return @get('currentRound') == 1
        ).property()

        timeBuffer: 15


    Frame =  Em.Object.extend
        imagePath: null
        order: null
        isEqual: (other) ->
            return @get('imagePath') == other.get('imagePath')
        clone: () ->
            return Frame.create({
                imagePath:@get('imagePath'),
                order: @get('order'),
            })

    return {
        Frame:Frame
        Frames:Frames
    }
