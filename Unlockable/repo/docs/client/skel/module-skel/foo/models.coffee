define ['ember', '_', 'cs!unlockable/models'],(Em, _, UnlockableModels) ->

    Foo =  UnlockableModels.Game.extend

        #for points calculation
        correctChoices: () ->

        gameActionsRating: () ->

        earnedAccuracyBounus: () ->

        timeBuffer: 10

    return {
        Foo:Foo
    }