define ['ember'
    '_'
    'cs!unlockable/unlockable'
    "cs!unlockable/jqueryui"
    "frames/templates"
    "touch_punch"
    ], (Em,
        _,
        Unlockable,
        jqueryui,
        templates) ->


    EMPTY_FRAME_IMG =  "img/placehold.gif"

    return {
        FramesView: Em.View.extend
            templateName: 'Frames'

        FramesInstructionsView: Em.View.extend
            templateName: "FramesInstructions"

        FramesCommercialView : Em.View.extend
            templateName: 'FramesCommercial'

        CurrentRoundView: Em.View.extend
            templateName: "FrameRound"

        ValidateCurrentRoundView: Em.View.extend
            templateName: "ValidateFrameRound"

        FramesPerformanceView: Em.View.extend
            templateName: "FramesPerformance"


        DropFrameView: Em.View.extend(jqueryui.Widget,
            uiType: 'droppable',
            uiEvents: ['drop'],
            uiOptions: ['hoverClass']
            hoverClass: (() ->
                if @get('frame?.locked')
                    return ""
                else
                    return "frame-hover"
            ).property("frame.locked")

            tagName: "span"
            locked: false

            dragOver: (event) ->
                if @get('frame.locked')
                    return false
                event.preventDefault()
                return false

            drop: (event, ui) ->
                if not ui
                    return false

                if @get('frame.locked')
                    return false
                viewId = ui.draggable.attr('id')

                localFrame = @get('frame')
                remoteFrameView = Em.View.views[viewId]
                remoteFrame = remoteFrameView.get('frame')

                swap = localFrame.get('imagePath')
                localFrame.set('imagePath', remoteFrame.get('imagePath'))
                remoteFrame.set('imagePath', swap)


                event.preventDefault()
                return false
        )

        DragFrameView: Em.View.extend(jqueryui.Widget,
            uiType: 'draggable',
            uiOptions: ['clone', 'revert', 'zIndex', "revertDuration"]
            tagName: "span"
            zIndex: 10
            helper: "clone"
            revert: true
            locked: false
            revertDuration: 0

            dragStart: (event) ->
                if this.get('frame.locked')
                    return false
                @set('zIndex', 100)

            dragEnter: (event) ->
                if this.get('frame.locked')
                    return false
                event.preventDefault()
                return false

            dragEnd: (event) ->
                 @set('zIndex', 10)

            image: (()->
                imagePath = @get("frame.imagePath")
                if not imagePath
                    return EMPTY_FRAME_IMG
                return Unlockable.cdn + "/" +imagePath
            ).property("frame", "frame.imagePath"))
    }