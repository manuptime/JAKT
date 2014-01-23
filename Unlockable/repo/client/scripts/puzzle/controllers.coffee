define ['ember', '_', 'cs!unlockable/controllers','cs!puzzle/models',  ],(Em, _, UnlockableControllers, Models) ->

    PuzzleController = UnlockableControllers.GameController.extend()

    PuzzleRoundController =  Em.ObjectController.extend
        contentBinding: 'Unlockable.router.puzzleController.content'

    PuzzlePerformanceController =  Em.ObjectController.extend
        contentBinding: 'Unlockable.router.puzzleController.content'
        starClass: (() ->
            stars = @get('stars')
            return "star-performance-#{ stars }"
        ).property()

    return {
        PuzzleController: PuzzleController
        PuzzleRoundController:PuzzleRoundController
        PuzzlePerformanceController:PuzzlePerformanceController
    }