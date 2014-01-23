define ['ember', '_', 'cs!unlockable/controllers','cs!dropblocks/models',  ],(Em, _, UnlockableControllers, Models) ->

    DropblocksController = UnlockableControllers.GameController.extend()

    DropblocksRoundController =  Em.ObjectController.extend
        contentBinding: 'Unlockable.router.dropblocksController.content'

    DropblocksPerformanceController =  Em.ObjectController.extend
        contentBinding: 'Unlockable.router.dropblocksController.content'
        starClass: (() ->
            stars = @get('stars')
            return "star-performance-#{ stars }"
        ).property()

    return {
        DropblocksController:DropblocksController
        DropblocksRoundController:DropblocksRoundController
        DropblocksPerformanceController:DropblocksPerformanceController
    }