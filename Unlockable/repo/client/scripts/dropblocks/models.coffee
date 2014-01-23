define ['ember', '_', 'cs!unlockable/models'],(Em, _, UnlockableModels) ->

    Dropblocks =  UnlockableModels.Game.extend
        #for points calculation
        correctChoices: (() ->
            @get('connected')
        ).property('connected')

        gameActionsRating: (() ->
            return 7
        ).property()

        earnedAccuracyBounus: (() ->
            return @get('connected') == 7
        ).property('connected')

        timeBuffer: 10

        connected: 0


    return {
        Dropblocks:Dropblocks
    }