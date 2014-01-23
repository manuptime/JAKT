define ['ember', '_', 'cs!unlockable/models'],(Em, _, UnlockableModels) ->

    Puzzle =  UnlockableModels.Game.extend
        #for points calculation
        correctChoices: (() ->
            @get('connected')
        ).property('connected')

        gameActionsRating: (() ->
            return 5
        ).property()

        earnedAccuracyBounus: (() ->
            return @get('connected') == 5
        ).property('connected')

        timeBuffer: 10

        connected: 0


    return {
        Puzzle:Puzzle
    }