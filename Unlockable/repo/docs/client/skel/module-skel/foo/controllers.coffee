define ['ember', '_', 'cs!unlockable/controllers','cs!./models',  ],(Em, _, UnlockableControllers, Models) ->

    FooControler = UnlockableControllers.GameController.extend()

    return {
        FooControler: FooControler
    }