getDocHeight = ->
  D = document
  Math.max Math.max(D.body.scrollHeight, D.documentElement.scrollHeight), Math.max(D.body.offsetHeight, D.documentElement.offsetHeight), Math.max(D.body.clientHeight, D.documentElement.clientHeight)
getDocWidth = ->
  D = document
  Math.max Math.max(D.body.scrollWidth, D.documentElement.scrollWidth), Math.max(D.body.offsetWidth, D.documentElement.offsetWidth), Math.max(D.body.clientWidth, D.documentElement.clientWidth)


windowResizeListener = (ev) ->
  #Adjust rendering surfaces
  FrameWidth = getDocWidth()
  FrameHeight = getDocHeight()
  ScreenEdgeRight = FrameWidth
  ScreenEdgeBottom = FrameHeight
  hBackBuffer.width = FrameWidth
  hBackBuffer.height = FrameHeight
  hBackRC = hBackBuffer.getContext("2d")
  frontbuffer = document.getElementById("maincanvas")
  frontbuffer.width = FrameWidth
  frontbuffer.height = FrameHeight
  hRC = frontbuffer.getContext("2d")
  i = 0

  while i < PuzzleChunks.length
    #Force puzzle pieces to clamp to view
    PuzzleChunks[i].Move 0, 0
    i++

DOMContentLoadedListner = (ev) ->
  FrameWidth = getDocWidth()
  FrameHeight = getDocHeight()
  PuzW = 3
  PuzH = 2
  VarList = window.location.search.substring(1).split("&")
  VideoSRC = document.getElementById("videosrc")

  #VideoSRC.src = "SUBWAYAD_2.mp4";
  i = 0

  while i < VarList.length
    VarPair = VarList[i].split("=")
    if VarPair[0] is "w"
      PuzW = parseInt(VarPair[1], 10)
    else if VarPair[0] is "h"
      PuzH = parseInt(VarPair[1], 10)
    else if VarPair[0] is "clip"
      VideoSRC.src = VarPair[1] + ".mp4"

    #VideoSRC.innerHTML = "<source src='SUBWAYAD.mp4' type=video/mp4>";
    #                        switch(parseInt(VarPair[1],10)){
    #                            case 1:
    #                                VideoSRC.src = "arby3.mp4";
    #                                break;
    #                            case 2:
    #                                VideoSRC.src = "arbys.mp4";
    #                                break;
    #                            default:
    #                                VideoSRC.src = "arby3.mp4";
    #                                break;
    #                        }
    else videoSizeMultiplier = parseFloat(VarPair[1])  if VarPair[0] is "size"
    i++

  #VideoSRC.load();
  BeginGame PuzW, PuzH


BreakVideo = ->
  Randomize PuzzleChunks
  PiecesPerSide = Math.floor(TotalPuzzlePieces / 4)
  i = 0
  j = 0

  #For Each Side
  Spacing = FrameWidth / (PiecesPerSide + 1) - PuzzlePieceWidth / 2

  #TOP
  i = 0
  while i < PiecesPerSide
    PuzzleChunks[j++].MoveTo Spacing * (i + 1), 0
    i++

  #BOTTOM
  i = 0
  while i < PiecesPerSide
    PuzzleChunks[j++].MoveTo Spacing * (i + 1), FrameHeight - PuzzlePieceHeight
    i++

  #LEFT
  Spacing = FrameHeight / (PiecesPerSide + 1) - PuzzlePieceHeight / 2
  i = 0
  while i < PiecesPerSide
    PuzzleChunks[j++].MoveTo 10, Spacing * (i + 1)
    i++

  #RIGHT - WHATEVER IS LEFT
  Remainder = PuzzleChunks.length - j
  Spacing = FrameHeight / (Remainder) - PuzzlePieceHeight / 2
  i = 0
  while i < Remainder
    PuzzleChunks[j++].MoveTo FrameWidth - PuzzlePieceWidth, Spacing * (i + 1)
    i++

#    for(var x = 0; x < PuzzleSubdivsH; x++){
#        for(var y = 0; y < PuzzleSubdivsV; y++){
#            var CurrentX = x * (PuzzleSpacing+PuzzlePieceWidth) + GameStartX;
#            var CurrentY = y * (PuzzleSpacing+PuzzlePieceHeight) + GameStartY;
#            PuzzleChunks[x + y*PuzzleSubdivsH].MoveTo(CurrentX, CurrentY);
#        }
#    }


    #*****************
    #On mouse click
    #****************

mouseDownListner =  ((event) ->
        hCurrentHover = null
        #For IE
        event = window.event  if event is null
        target = (if event.target isnt null then event.target else event.srcElement)
        document.onselectstart = ->
            false
        target.ondragstart = ->
            false
        CurrentX = event.clientX + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft)
        CurrentY = event.clientY + Math.max(document.documentElement.scrollTop, document.body.scrollTop)
        PrevMouseX = CurrentX
        PrevMouseY = CurrentY
        bClickedObject = false
        i = 0
        while i < PuzzleChunks.length
            CurrentChunk = PuzzleChunks[i]

            #TODO - Select nearest intersection point?
            if CurrentChunk.PointOverlaps(CurrentX, CurrentY)
                hCurrentDrag = CurrentChunk
                CurrentChunk.DestX = -1
                CurrentChunk.DestY = -1
                bClickedObject = true
                break
            i++
        hCurrentDrag = null  unless bClickedObject
    )

mouseupListner = (event) ->
  if hCurrentDrag isnt null and hSnapTarget isnt null

    #See if these pieces actually belong together
    if hSnapTarget.connections[SideToSnap] is hCurrentDrag.Pieces[SnapOriginIndex]
      nConnectedPieces++
      ParentChunk = hSnapTarget.Parent

      #ParentChunk.FloorXY(); //TODO - See if flooring the position helps at all with the fuzzy edges
      #Move the pieces into place and merge the chunks!
      FutureX = 0
      FutureY = 0
      switch SideToSnap
        when Snap.TOP
          FutureX = hSnapTarget.X
          FutureY = hSnapTarget.Y - PuzzlePieceHeight
        when Snap.BOTTOM
          FutureX = hSnapTarget.X
          FutureY = hSnapTarget.Y + PuzzlePieceHeight
        when Snap.RIGHT
          FutureX = hSnapTarget.X + PuzzlePieceWidth
          FutureY = hSnapTarget.Y
        when Snap.LEFT
          FutureX = hSnapTarget.X - PuzzlePieceWidth
          FutureY = hSnapTarget.Y
      hCurrentDrag.Move_IgnoreBounds FutureX - hCurrentDrag.Pieces[SnapOriginIndex].X, FutureY - hCurrentDrag.Pieces[SnapOriginIndex].Y

      #Copy over pieces to the new parent
      i = 0

      while i < hCurrentDrag.Pieces.length
        ParentChunk.Add hCurrentDrag.Pieces[i]
        i++

      #Now we get rid of the old parent
      PuzzleChunks.splice PuzzleChunks.indexOf(hCurrentDrag), 1

      #TODO - BETTER WIN SCENARIO, OBV.
      if ParentChunk.Pieces.length is TotalPuzzlePieces and not bWonGame
        bWonGame = true
        ParentChunk.MoveTo GameCenterX, GameCenterY
    else

  #These pieces don't belong together. Wave the proverbial index finger in disgust.
  hSnapTarget = null
  hCurrentDrag = null



Update = ->
  if bGameStarted
    unless bWonGame or bLostGame
      nPlayerTime += 20
      bLostGame = true  if nPlayerTime >= 30000

    #TODO - Optimize
    bFoundSnapTarget = false
    DistanceLimit = (PuzzlePieceWidth * PuzzlePieceWidth) * 1.8
    ClosestDistance = DistanceLimit
    i = 0

    while i < PuzzleChunks.length
      PuzzleChunks[i].Update()
      if hCurrentDrag isnt null and PuzzleChunks[i] isnt hCurrentDrag
        j = 0

        while j < PuzzleChunks[i].Pieces.length
          TestPiece = PuzzleChunks[i].Pieces[j]
          k = 0

          while k < hCurrentDrag.Pieces.length
            DragPiece = hCurrentDrag.Pieces[k]
            CurrentDistance = SqDistance(DragPiece.X, DragPiece.Y, TestPiece.X, TestPiece.Y)
            if CurrentDistance < DistanceLimit

              #Find nearest side! Airthmatic is always fastest
              OffsetX = TestPiece.X - DragPiece.X
              OffsetY = TestPiece.Y - DragPiece.Y

              #TODO - OPTIMIZE SLIGHTLY
              DistanceX = Math.abs(OffsetX)
              DistanceY = Math.abs(OffsetY)
              DistanceToNearestEdge = 0
              if DistanceX > DistanceY

                #We're off to the sides
                if OffsetX > 0 and TestPiece.connections[Snap.LEFT] isnt hPuzzlePieceDummy
                  DistanceToNearestEdge = Math.abs(TestPiece.X - (DragPiece.X + PuzzlePieceWidth))
                  if DistanceToNearestEdge < ClosestDistance
                    ClosestDistance = DistanceToNearestEdge
                    bFoundSnapTarget = true
                    hSnapTarget = TestPiece
                    SnapOriginIndex = k
                    SideToSnap = Snap.LEFT
                else unless TestPiece.connections[Snap.RIGHT] is hPuzzlePieceDummy
                  DistanceToNearestEdge = Math.abs((TestPiece.X + PuzzlePieceWidth) - DragPiece.X)
                  if DistanceToNearestEdge < ClosestDistance
                    ClosestDistance = DistanceToNearestEdge
                    bFoundSnapTarget = true
                    hSnapTarget = TestPiece
                    SnapOriginIndex = k
                    SideToSnap = Snap.RIGHT
              else

                #Vertically
                if OffsetY > 0 and TestPiece.connections[Snap.TOP] isnt hPuzzlePieceDummy
                  DistanceToNearestEdge = Math.abs(TestPiece.Y - (DragPiece.Y + PuzzlePieceHeight))
                  if DistanceToNearestEdge < ClosestDistance
                    ClosestDistance = DistanceToNearestEdge
                    bFoundSnapTarget = true
                    hSnapTarget = TestPiece
                    SnapOriginIndex = k
                    SideToSnap = Snap.TOP
                else unless TestPiece.connections[Snap.BOTTOM] is hPuzzlePieceDummy
                  DistanceToNearestEdge = Math.abs((TestPiece.Y + PuzzlePieceHeight) - DragPiece.Y)
                  if DistanceToNearestEdge < ClosestDistance
                    ClosestDistance = DistanceToNearestEdge
                    bFoundSnapTarget = true
                    hSnapTarget = TestPiece
                    SnapOriginIndex = k
                    SideToSnap = Snap.BOTTOM
            k++
          j++
      i++
    hSnapTarget = null  unless bFoundSnapTarget


Render = ->

  #if(VideoSRC.paused || VideoSRC.ended) return false;
  hBackRC.clearRect 0, 0, FrameWidth, FrameHeight
  hRC.clearRect 0, 0, FrameWidth, FrameHeight

  #hBackRC.save();

  #hBackRC.translate(A.X, A.Y);
  #hBackRC.rotate(X);
  #RenderShadowMap();
  #hBackRC.globalAlpha = 0.5;
  #hBackRC.drawImage(hShadowMap, ShadowOffsetX, ShadowOffsetY, FrameWidth, FrameHeight);
  #hBackRC.globalAlpha = 1.0;

  #Draw Shadows
  #TODO - Think about this
  hBackRC.beginPath()
  i = 0
  j = 0
  CurrentChunk = null
  CurrentPiece = null
  i = 0
  while i < PuzzleChunks.length
    CurrentChunk = PuzzleChunks[i]
    j = 0
    while j < CurrentChunk.Pieces.length
      CurrentPiece = CurrentChunk.Pieces[j]

      #hBackRC.drawImage(hShadowImage, CurrentPiece.X + 5, CurrentPiece.Y + 5);
      ShLeft = CurrentPiece.X
      ShRight = ShLeft + PuzzlePieceWidth
      ShTop = CurrentPiece.Y
      ShBottom = ShTop + PuzzlePieceHeight
      hBackRC.moveTo ShLeft, ShBottom
      hBackRC.lineTo ShRight, ShBottom
      hBackRC.lineTo ShRight, ShTop
      j++
    i++

  #hBackRC.closePath();
  hBackRC.lineWidth = 10
  hBackRC.strokeStyle = "rgba(0, 0, 0, 0.15)"
  hBackRC.stroke()
  hBackRC.lineWidth = 8
  hBackRC.strokeStyle = "rgba(0, 0, 0, 0.15)"
  hBackRC.stroke()
  hBackRC.lineWidth = 6
  hBackRC.strokeStyle = "rgba(0, 0, 0, 0.15)"
  hBackRC.stroke()
  hBackRC.lineWidth = 4
  hBackRC.strokeStyle = "rgba(0, 0, 0, 0.25)"
  hBackRC.stroke()

  #Draw border around hover targets
  if hCurrentHover isnt null
    hBackRC.beginPath()
    h = 0

    while h < hCurrentHover.length
      Piece = hCurrentHover[h]
      BLeft = Piece.X - 1
      BUp = Piece.Y - 1
      hBackRC.moveTo BLeft, BUp
      hBackRC.lineTo Piece.X + PuzzlePieceWidth, BUp
      hBackRC.lineTo Piece.X + PuzzlePieceWidth, Piece.Y + PuzzlePieceHeight
      hBackRC.lineTo BLeft, Piece.Y + PuzzlePieceHeight
      hBackRC.lineTo BLeft, BUp
      hBackRC.closePath()
      h++

    #hBackRC.closePath();
    hBackRC.lineWidth = 6
    hBackRC.strokeStyle = "#FFFF00"
    hBackRC.stroke()

  #
  #        hBackRC.lineWidth = 5;
  #        hBackRC.strokeStyle = "rgba(255, 255, 0, 0.35)";
  #        hBackRC.stroke();
  #
  #        hBackRC.lineWidth = 3;
  #        hBackRC.strokeStyle = "rgba(255, 255, 0, 1)";
  #        hBackRC.stroke();
  i = 0
  while i < PuzzleChunks.length
    CurrentChunk = PuzzleChunks[i]
    j = 0
    while j < CurrentChunk.Pieces.length
      CurrentPiece = CurrentChunk.Pieces[j]
      hBackRC.drawImage VideoSRC, CurrentPiece.srcX, CurrentPiece.srcY, PuzzlePieceWidth, PuzzlePieceHeight, Math.floor(CurrentPiece.X), Math.floor(CurrentPiece.Y), PuzzlePieceWidth, PuzzlePieceHeight
      j++
    i++
  if hSnapTarget isnt null
    hBackRC.beginPath()
    Ax = hSnapTarget.GetEdgeCenterX(SideToSnap)
    Ay = hSnapTarget.GetEdgeCenterY(SideToSnap)
    Bx = 0
    By = 0
    hBackRC.arc Ax, Ay, 10, 0, 2 * Math.PI, false
    switch SideToSnap
      when Snap.TOP
        Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.BOTTOM)
        By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.BOTTOM)
      when Snap.BOTTOM
        Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.TOP)
        By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.TOP)
      when Snap.RIGHT
        Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.LEFT)
        By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.LEFT)
      when Snap.LEFT
        Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.RIGHT)
        By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.RIGHT)
    hBackRC.arc Bx, By, 10, 0, 2 * Math.PI, false
    hBackRC.closePath()
    hBackRC.fillStyle = "blue"
    hBackRC.fill()
    hBackRC.beginPath()
    hBackRC.moveTo Ax, Ay
    hBackRC.lineTo Bx, By
    hBackRC.lineWidth = "2"
    hBackRC.strokeStyle = "#9999FF"
    hBackRC.stroke()
  RenderTimer()  unless VideoSRC.paused
  hBackRC.drawImage hTimerImage, TimerX, TimerY

  #hBackRC.restore();
  if bWonGame
    hBackRC.font = "40pt sans-serif"
    hBackRC.fillStyle = "#FFFFFF"
    hBackRC.strokeStyle = "black"
    hBackRC.strokeText "SUCCESS!", 200, 200
    hBackRC.fillText "SUCCESS!", 200, 200
    strTimeWon = "Completed in " + nPlayerTime / 1000 + " seconds"
    hBackRC.strokeText strTimeWon, 200, 300
    hBackRC.fillText strTimeWon, 200, 300
  else if bLostGame
    hBackRC.font = "40pt sans-serif"
    hBackRC.fillStyle = "#FFFFFF"
    hBackRC.strokeStyle = "black"
    hBackRC.strokeText "Game Over", 200, 200
    hBackRC.fillText "Game Over", 200, 200

    #Compute progress
    #var nConnectedPieces = 0;
    #                    for(var k = 0; k < PuzzleChunks.length; k++){
    #                        var Chunk = PuzzleChunks[k];
    #                        if(Chunk.Pieces.length > 1)
    #                            nConnectedPieces += Chunk.Pieces.length;
    #                    }
    strProgress = "You made " + nConnectedPieces + " out of " + (TotalPuzzlePieces - 1) + " connections"

    #var strProgress = "You connected " + Math.floor((nConnectedPieces/TotalPuzzlePieces) * 100.0) + "% of the puzzle";
    hBackRC.strokeText strProgress, 200, 300
    hBackRC.fillText strProgress, 200, 300
  hRC.drawImage hBackBuffer, 0, 0, FrameWidth, FrameHeight


Randomize = (myArray) ->
  i = myArray.length
  return false  if i is 0
  while --i
    j = Math.floor(Math.random() * (i + 1))
    tempi = myArray[i]
    tempj = myArray[j]
    myArray[i] = tempj
    myArray[j] = tempi


RestartVideo = ->
  VideoSRC.currentTime = 0
PauseVideo = ->
  if VideoSRC.paused is false
    VideoSRC.pause()
  else
    VideoSRC.play()



mousemoveListner = (event) ->
        #For IE
        event = window.event  if event is null
        CurrentX = event.clientX + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft)
        CurrentY = event.clientY + Math.max(document.documentElement.scrollTop, document.body.scrollTop)
        if hCurrentDrag isnt null
            DeltaX = CurrentX - PrevMouseX
            DeltaY = CurrentY - PrevMouseY

          #                    if(DeltaX < 0 && hCurrentDrag.MinX < ScreenEdgeLeft){
          #                        DeltaX = 0;
          #                    }
          #                    if(DeltaX > 0 && hCurrentDrag.MaxX > ScreenEdgeRight){
          #                        DeltaX = 0;
          #                    }
          #                    if(DeltaY < 0 && hCurrentDrag.MinY < ScreenEdgeTop){
          #                        DeltaY = 0;
          #                    }
          #                    if(DeltaY > 0 && hCurrentDrag.MaxY > ScreenEdgeBottom){
          #                        DeltaY = 0;
          #                    }
            hCurrentDrag.Move DeltaX, DeltaY
            PrevMouseX = CurrentX
            PrevMouseY = CurrentY
        else

          #Hovering over someone?
            bFoundHover = false
            document.body.style.cursor = "pointer"
            i = 0
            while i < PuzzleChunks.length
                CurrentChunk = PuzzleChunks[i]

                #TODO - Fix Z FIghting when hovering over multiple pieces at once
                # ??? Moot? Pieces wil avoid eachother right? Still, try to fight it.
                if CurrentChunk.PointOverlaps(CurrentX, CurrentY)
                    hCurrentHover = CurrentChunk.Pieces
                    bFoundHover = true
                    #Make CurrentChunk the last one so it has Z Priority
                    LastChunk = PuzzleChunks.length - 1
                    unless i is LastChunk
                        #Swap!
                        PuzzleChunks[i] = PuzzleChunks[LastChunk]
                        PuzzleChunks[LastChunk] = CurrentChunk
                    break
                i++
            unless bFoundHover
                hCurrentHover = null
                document.body.style.cursor = "default"
