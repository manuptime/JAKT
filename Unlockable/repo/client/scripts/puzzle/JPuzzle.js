define(['ember', '_', 'cs!puzzle/models'], function(Em, _, Models) {

    var PuzzlePieceArea = 0;
    var PuzzlePieceMargin = 15;
    var ScreenEdgeBottom = 0;
    var ScreenEdgeRight = 0;
    var PuzW = 3;
    var PuzH = 2;

    //In case you want to upscale the src video
    var videoSizeMultiplier = 0.85;

    var Snap = {
        TOP : 0,
        RIGHT : 1,
        BOTTOM : 2,
        LEFT : 3
    };
    var SideToSnap = -1;
    var SnapOriginIndex = -1;

    var PuzzleSpacing = 30;
    var PuzzleSubdivsH = 3;
    var PuzzleSubdivsV = 2;
    var TotalPuzzlePieces = 6;
    var PuzzlePieceWidth = 160;
    var PuzzlePieceHeight = 120;
    var PuzzlePieceHalfWidth = 20;
    var PuzzlePieceHalfHeight = 20;
    var HoverBorderWidth = 2;
    var DoubleBorderWidth = HoverBorderWidth * 2;

    function Lerp(a, b, s){
        return b - ((1.0 - s) * (b - a));
    }
    function SqDistance(Ax, Ay, Bx, By){
        var A = Ax - Bx;
        var B = Ay - By;
        return A*A + B*B;
    }



    function JPuzzle(videotag, observer){

        var nConnectedPieces = 0;
        var bWonGame = false;
        var bLostGame = false;
        var FrameWidth = 800;
        var FrameHeight = 480;

        var FrameHeight = window.innerHeight;
        var FrameWidth  = window.innerWidth;

        var GameCenterX = FrameWidth / 2;
        var GameCenterY = FrameHeight / 2;
        var GameStartX = 200;
        var GameStartY = 200;
        var hSnapTarget = null;
        var hCurrentDrag = null;
        var hCurrentHover = null;

        var hTimerImage = null;
        var hTimerRC = null;
        var nPlayerTime = 0.0;
        var bGameInit = false;
        var hPuzzlePieceDummy = new PuzzlePiece();
        var vidRenderInterval = null;
        var VideoSRC = videotag;
        var hBackBuffer = null;
        var hBackRC = null;
        var hRC = null;
        var hShadowImage = null;

        var PrevMouseX = 0;
        var PrevMouseY = 0;
        var bGameStarted = false;


        var PuzzlePieces = [];
        var PuzzleChunks = [];
        function PuzzlePiece(){
            this.X = 0;
            this.Y = 0;
            this.srcX = 0;
            this.srcY = 0;
            this.connections = [null,null,null,null];
            this.Parent = null;
        }
        PuzzlePiece.prototype.Move = function(x, y){
            this.X += x;
            this.Y += y;
        };
        PuzzlePiece.prototype.PointOverlaps = function(x, y){
            return (x > this.X && x < this.X + PuzzlePieceWidth + PuzzlePieceMargin && y > this.Y && y < this.Y + PuzzlePieceHeight + PuzzlePieceMargin );
        };
        PuzzlePiece.prototype.GetEdgeCenterX = function(Edge){
            switch(Edge){
            case Snap.TOP:
                return this.X + PuzzlePieceHalfWidth;
            case Snap.BOTTOM:
                return this.X + PuzzlePieceHalfWidth;
            case Snap.RIGHT:
                return this.X + PuzzlePieceWidth;
            case Snap.LEFT:
                return this.X;
            }
        };


        PuzzlePiece.prototype.GetEdgeCenterY = function(Edge){
            switch(Edge){
            case Snap.TOP:
                return this.Y;
            case Snap.BOTTOM:
                return this.Y + PuzzlePieceHeight;
            case Snap.RIGHT:
                return this.Y + PuzzlePieceHalfHeight;
            case Snap.LEFT:
                return this.Y + PuzzlePieceHalfHeight;
            }
        };
        PuzzlePiece.prototype.Overlaps = function(TargetPiece){
            var Overlap = 0.0;
            if(this.X < TargetPiece.X + PuzzlePieceWidth && this.X + PuzzlePieceWidth + PuzzlePieceMargin > TargetPiece.X && this.Y < TargetPiece.Y + PuzzlePieceHeight && this.Y + PuzzlePieceHeight + PuzzlePieceMargin > TargetPiece.Y){
                //Get the exact area
                //TODO - optimize?
                var OverlapX = 0.0;
                var OverlapY = 0.0;
                if(this.X > TargetPiece.X){
                    OverlapX = TargetPiece.X + PuzzlePieceWidth - this.X + PuzzlePieceMargin;
                }else{
                    OverlapX = this.X + PuzzlePieceWidth - TargetPiece.X + PuzzlePieceMargin;
                }
                if(this.Y > TargetPiece.Y){
                    OverlapY = TargetPiece.Y + PuzzlePieceHeight - this.Y + PuzzlePieceMargin;
                }else{
                    OverlapY = this.Y + PuzzlePieceHeight - TargetPiece.Y + PuzzlePieceMargin;
                }
                Overlap = OverlapX * OverlapY;
            }
            return Overlap;
        };
        //Puzzle Chunk represents a group of pieces
        //that can be dragged together
        function PuzzleChunk(){
            this.MinX = 0;
            this.MinY = 0;
            this.MaxX = 0;
            this.MaxY = 0;
            this.Pieces = [];
            this.DestX = -1;
            this.DestY = -1;
            this.Speed = 0.3;
            this.X = 0;
            this.Y = 0;
        }
        PuzzleChunk.prototype.PointOverlaps = function(x, y){
            if(x > this.MinX && x < this.MaxX && y > this.MinY && y < this.MaxY){
                for(var i = 0; i < this.Pieces.length; i++){
                    if(this.Pieces[i].PointOverlaps(x,y)){
                        return true;
                    }
                }
            }
            return false;
        };
        PuzzleChunk.prototype.Move_IgnoreBounds = function(x,y){
            //                if(x !== 0){
            //                    this.X += x;
            //                    this.MinX += x;
            //                    this.MaxX += x;
            //                }
            //
            //                if(y !== 0){
            //                    this.Y += y;
            //                    this.MinY += y;
            //                    this.MaxY += y;
            //                }

            for(var i = 0; i < this.Pieces.length; i++){
                this.Pieces[i].Move(x, y);
            }
        };
        PuzzleChunk.prototype.FloorXY = function(){
            var DeltaX = this.X - Math.floor(this.X);
            var DeltaY = this.Y - Math.floor(this.Y);
            this.Move(DeltaX, DeltaY);
        };
        PuzzleChunk.prototype.Move = function(x, y){
            //Check to make sure we're not going past the screen edge
            var FutureMinX = this.MinX + x;
            var FutureMaxX = this.MaxX + x;

            if(FutureMinX < 0){
                x = -this.MinX;
            }else if(FutureMaxX > ScreenEdgeRight){
                x = ScreenEdgeRight - this.MaxX;
            }
            if(x !== 0){
                this.X += x;
                this.MinX += x;
                this.MaxX += x;
            }

            var FutureMinY = this.MinY + y;
            var FutureMaxY = this.MaxY + y;
            if(FutureMinY < 0){
                y = -this.MinY;
            }else if(FutureMaxY > ScreenEdgeBottom){
                y = ScreenEdgeBottom - this.MaxY;
            }
            if(y !== 0){
                this.Y += y;
                this.MinY += y;
                this.MaxY += y;
            }

            for(var i = 0; i < this.Pieces.length; i++){
                this.Pieces[i].Move(x, y);
            }
        };
        PuzzleChunk.prototype.MoveTo = function(x, y){
            this.DestX = x;
            this.DestY = y;
        };
        PuzzleChunk.prototype.Add = function(NewPiece){
            NewPiece.Parent = this;
            this.Pieces.push(NewPiece);
            //Recompute center
            var sumX = 0;
            var sumY = 0;

            //TODO - Improve?
            this.MinY = this.Pieces[0].Y;
            this.MaxY = this.MinY + PuzzlePieceHeight;
            this.MinX = this.Pieces[0].X;
            this.MaxX = this.MinX + PuzzlePieceWidth;
            var nChildren = this.Pieces.length;
            for(var i = 0; i < nChildren; i++){
                var CurrentPiece = this.Pieces[i];
                sumX += CurrentPiece.X;
                sumY += CurrentPiece.Y;

                if(CurrentPiece.X < this.MinX){
                    this.MinX = CurrentPiece.X;
                }else if(CurrentPiece.X + PuzzlePieceWidth > this.MaxX){
                    this.MaxX = CurrentPiece.X + PuzzlePieceWidth;
                }
                if(CurrentPiece.Y < this.MinY){
                    this.MinY = CurrentPiece.Y;
                }else if(CurrentPiece.Y + PuzzlePieceHeight > this.MaxY){
                    this.MaxY = CurrentPiece.Y + PuzzlePieceHeight;
                }
                for(var j = 0; j < 4; j++){
                    if(CurrentPiece.connections[j] !== null && CurrentPiece.connections[j].Parent == this){
                        CurrentPiece.connections[j] = hPuzzlePieceDummy;
                    }
                }
            }
            this.X = sumX / nChildren;
            this.Y = sumY / nChildren;
        };



        PuzzleChunk.prototype.Overlaps = function(TargetChunk){
            if((this != hCurrentDrag && TargetChunk != hCurrentDrag) && this.MinX < TargetChunk.MaxX + PuzzlePieceMargin && this.MaxX + PuzzlePieceMargin > TargetChunk.MinX && this.MinY < TargetChunk.MaxY + PuzzlePieceMargin && this.MaxY + PuzzlePieceMargin > TargetChunk.MinY){
                //if((this != hCurrentDrag && TargetChunk != hCurrentDrag) && SqDistance(this.X, this.Y, TargetChunk.X, TargetChunk.Y) < 1000){
                //Bounds overlap, check into individual pieces o(n^2)
                var Overlap = 0.0;
                for(var i = 0; i < this.Pieces.length; i++){
                    for(var j = 0; j < TargetChunk.Pieces.length; j++){
                        Overlap += this.Pieces[i].Overlaps(TargetChunk.Pieces[j]);
                    }
                }
                return Overlap;
            }else{
                return 0;
            }
        };


        PuzzleChunk.prototype.Update = function(){
            var FleeSpeed = 290;
            if(this.DestX > 0){
                var FutureX = Lerp(this.X, this.DestX, 0.07);
                var FutureY = Lerp(this.Y, this.DestY, 0.07);
                this.Move(FutureX - this.X, FutureY - this.Y);
                if(Math.abs(this.X - this.DestX) < 1 && Math.abs(this.Y - this.DestY) < 1 ){
                    this.DestX = -1;
                    this.DestY = -1;
                }
            }else{
                for(var i = 0; i < PuzzleChunks.length; i++){
                    var TargetChunk = PuzzleChunks[i];
                    if(TargetChunk != this && TargetChunk.DestX <= 0){
                        var TotalOverlapArea = this.Overlaps(TargetChunk);
                        if(TotalOverlapArea > 200){
                            FleeSpeed += (TotalOverlapArea/PuzzlePieceArea) * 250;
                            var DeltaX = this.X - TargetChunk.X;
                            var DeltaY = this.Y - TargetChunk.Y;


                            var Length = DeltaX*DeltaX + DeltaY*DeltaY;
                            DeltaX /= Length;
                            DeltaY /= Length;
                            this.Move(DeltaX * FleeSpeed, DeltaY * FleeSpeed);
                            break;
                        }
                    }
                }
            }
        };




        function mouseDown(event){
            hCurrentHover = null;
            //For IE
            if (event === null)
                event = window.event;

            var target = event.target !== null ? event.target : event.srcElement;
            document.onselectstart = function () { return false; };
            target.ondragstart = function() { return false; };

            var CurrentX = event.clientX + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
            var CurrentY = event.clientY + Math.max(document.documentElement.scrollTop, document.body.scrollTop);
            PrevMouseX = CurrentX;
            PrevMouseY = CurrentY;
            var bClickedObject = false;
            for(var i = 0; i < PuzzleChunks.length; i++){
                var CurrentChunk = PuzzleChunks[i];
                //TODO - Select nearest intersection point?
                if(CurrentChunk.PointOverlaps(CurrentX, CurrentY)){
                    hCurrentDrag = CurrentChunk;
                    CurrentChunk.DestX = -1;
                    CurrentChunk.DestY = -1;
                    bClickedObject = true;
                    break;
                }
            }
            if(!bClickedObject){
                hCurrentDrag = null;
            }
        }
        function mouseMove(event){
            //For IE
            if (event === null)
                event = window.event;

            var CurrentX = event.clientX + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
            var CurrentY = event.clientY + Math.max(document.documentElement.scrollTop, document.body.scrollTop);
            if(hCurrentDrag !== null){
                var DeltaX = CurrentX - PrevMouseX;
                var DeltaY = CurrentY - PrevMouseY;
                hCurrentDrag.Move(DeltaX, DeltaY);

                PrevMouseX = CurrentX;
                PrevMouseY = CurrentY;
            }else{
                //Hovering over someone?
                var bFoundHover = false;
                document.body.style.cursor = "pointer";
                for(var i = 0; i < PuzzleChunks.length; i++){
                    var CurrentChunk = PuzzleChunks[i];
                    //TODO - Fix Z FIghting when hovering over multiple pieces at once
                    // ??? Moot? Pieces wil avoid eachother right? Still, try to fight it.
                    if(CurrentChunk.PointOverlaps(CurrentX, CurrentY)){
                        hCurrentHover = CurrentChunk.Pieces;
                        bFoundHover = true;
                        //Make CurrentChunk the last one so it has Z Priority
                        var LastChunk = PuzzleChunks.length - 1;
                        if(i != LastChunk){
                            //Swap!
                            PuzzleChunks[i] = PuzzleChunks[LastChunk];
                            PuzzleChunks[LastChunk] = CurrentChunk;
                        }
                        break;
                    }
                }
                if(!bFoundHover){
                    hCurrentHover = null;
                    document.body.style.cursor = "default";
                }
            }
        }

        function mouseUp(event){
            if(hCurrentDrag !== null && hSnapTarget !== null){
                //See if these pieces actually belong together
                if(hSnapTarget.connections[SideToSnap] == hCurrentDrag.Pieces[SnapOriginIndex]){
                    observer.connected()
                    var ParentChunk = hSnapTarget.Parent;
                    //ParentChunk.FloorXY(); //TODO - See if flooring the position helps at all with the fuzzy edges
                    //Move the pieces into place and merge the chunks!
                    var FutureX = 0;
                    var FutureY = 0;
                    switch(SideToSnap){
                    case Snap.TOP:
                        FutureX = hSnapTarget.X;
                        FutureY = hSnapTarget.Y - PuzzlePieceHeight;
                        break;
                    case Snap.BOTTOM:
                        FutureX = hSnapTarget.X;
                        FutureY = hSnapTarget.Y + PuzzlePieceHeight;
                        break;
                    case Snap.RIGHT:
                        FutureX = hSnapTarget.X + PuzzlePieceWidth;
                        FutureY = hSnapTarget.Y;
                        break;
                    case Snap.LEFT:
                        FutureX = hSnapTarget.X - PuzzlePieceWidth;
                        FutureY = hSnapTarget.Y;
                        break;
                    }
                    hCurrentDrag.Move_IgnoreBounds(FutureX - hCurrentDrag.Pieces[SnapOriginIndex].X, FutureY - hCurrentDrag.Pieces[SnapOriginIndex].Y);
                    //Copy over pieces to the new parent
                    for(var i = 0; i < hCurrentDrag.Pieces.length; i++){
                        ParentChunk.Add(hCurrentDrag.Pieces[i]);
                    }
                    //Now we get rid of the old parent
                    PuzzleChunks.splice(PuzzleChunks.indexOf(hCurrentDrag), 1);

                    //TODO - BETTER WIN SCENARIO, OBV.
                    if(ParentChunk.Pieces.length == TotalPuzzlePieces && !bWonGame){
                        bWonGame = true;
                        observer.wonGame();
                        //ParentChunk.MoveTo(GameCenterX, GameCenterY);
                    }
                }else{
                    //These pieces don't belong together. Wave the proverbial index finger in disgust.
                }
            }
            hSnapTarget = null;
            hCurrentDrag = null;
        }




        function initPuzzle() {
            if(bGameInit === false){
                bGameInit = true;
                VideoSRC.videoWidth *= videoSizeMultiplier;
                VideoSRC.videoHeight *= videoSizeMultiplier;
                PuzzlePieceWidth = VideoSRC.videoWidth / PuzzleSubdivsH;
                PuzzlePieceHeight = VideoSRC.videoHeight / PuzzleSubdivsV;
                //InitializeShadowImage(); //Once we have the width, we need to init the shadow immediately
                PuzzlePieceArea = PuzzlePieceWidth * PuzzlePieceHeight;
                PuzzlePieceHalfWidth = PuzzlePieceWidth / 2;
                PuzzlePieceHalfHeight = PuzzlePieceHeight / 2;
                //First just initialize the puzzle grid
                //TODO - Make this a little faster? It might not really be noticeable
                //GameStartX = FrameWidth/2 - VideoSRC.videoWidth/2;
                //GameStartY = FrameHeight/2 - VideoSRC.videoHeight/2;

                var modalH = $('.unlockable-modal').height()
                var modalW = $('.unlockable-modal').width()

                GameStartX = Math.ceil((FrameWidth/2 - modalW/2) + modalW * 0.17);
                GameStartY = 150;

                /*console.log("innerHeight:          " + window.innerHeight);
				console.log("innerWidth:           " + window.innerWidth);
                console.log("VideoSRC.videoWidth:  " + VideoSRC.videoWidth); 
                console.log("VideoSRC.videoHeight: " + VideoSRC.videoHeight); */

                for(var i = 0; i < TotalPuzzlePieces; i++){
                    PuzzlePieces.push(new PuzzlePiece());
                }
                var RightBound = PuzzleSubdivsH - 1;
                var BottomBound = PuzzleSubdivsV - 1;
                for(var x = 0; x < PuzzleSubdivsH; x++){
                    for(var y = 0; y < PuzzleSubdivsV; y++){
                        var index = x + y*PuzzleSubdivsH;
                        var CurrentPiece = PuzzlePieces[index];
                        var mPC = new PuzzleChunk();
                        CurrentPiece.X = x * PuzzlePieceWidth;
                        CurrentPiece.Y = y * PuzzlePieceHeight;
                        //If we have a multiplier, we need to divide back by it
                        //to get the proper reading points in the source video
                        CurrentPiece.srcX = CurrentPiece.X;
                        CurrentPiece.srcY = CurrentPiece.Y;

                        CurrentPiece.X += GameStartX;
                        CurrentPiece.Y += GameStartY;

                        //Link up to its neighbors
                        if(x > 0){
                            CurrentPiece.connections[Snap.LEFT] = PuzzlePieces[index - 1];
                        }
                        if(x < RightBound){
                            CurrentPiece.connections[Snap.RIGHT] = PuzzlePieces[index + 1];
                        }
                        if(y > 0){
                            CurrentPiece.connections[Snap.TOP] = PuzzlePieces[index - PuzzleSubdivsH];
                        }
                        if(y < BottomBound){
                            CurrentPiece.connections[Snap.BOTTOM] = PuzzlePieces[index + PuzzleSubdivsH];
                        }
                        mPC.Add(CurrentPiece);
                        PuzzleChunks.push(mPC);
                    }
                }
            }
        }


        function startVideo(){
            VideoSRC.play()
        }



        function beginGame(){
            setTimeout(BreakVideo, 2000);
            bGameStarted = true;
            vidRenderInterval = setInterval(function(){
                    Update();
                    Render();
                }, 20);
        }


        function PrepareContainer(width, height){
            //TODO - Make this dynamic so it gets updated automatically
            ScreenEdgeBottom = FrameHeight;
            ScreenEdgeRight = FrameWidth;
            PuzzleSubdivsH = width;
            PuzzleSubdivsV = height;
            TotalPuzzlePieces = PuzzleSubdivsH * PuzzleSubdivsV;
            //Setup back and front buffers
             // hBackBuffer = document.getElementById('backcanvas');
             // hBackBuffer.width = FrameWidth;
             // hBackBuffer.height = FrameHeight;
            hBackBuffer = $('#backcanvas');
            hBackBuffer.attr('width', FrameWidth);
            hBackBuffer.attr('height', FrameHeight);

            hBackBuffer.css({
                position: 'fixed',
                top: '0px',
                left: '0px',
            });
            hBackBuffer = hBackBuffer[0] //blah, I know.
            hBackRC = hBackBuffer.getContext('2d');
            // var frontbuffer = document.getElementById('maincanvas');
            // frontbuffer.width = FrameWidth;
            // frontbuffer.height = FrameHeight;

            // hRC = frontbuffer.getContext('2d');

            var frontbuffer = $('#maincanvas');
            frontbuffer.attr('width', FrameWidth);
            frontbuffer.attr('height', FrameHeight);
            frontbuffer.css({
                position: 'fixed',
                top: '0px',
                left: '0px',
            });

            hRC = frontbuffer[0].getContext('2d');
        }

        function jag(j){
            if (j % 2 == 0){
                var move = PuzzlePieceWidth * 0.45;
			}
			else{
                var move = PuzzlePieceWidth * 0.55; 
			}
            return Math.ceil(move);
		}

        function spacing(i){
            if (i == 0){
                return PuzzlePieceWidth * 1.00;
			}
            else{
                return (PuzzlePieceWidth * 2.50 * i);
			}
		}

        function BreakVideo(){
            bindEvents()
            PuzzleChunks = _.shuffle(PuzzleChunks);
            var PiecesPerSide = Math.floor(TotalPuzzlePieces / 4);
            var i = 0;
            var j = 0;

            var modalH = $('.unlockable-modal').height()
            var modalW = $('.unlockable-modal').width()
            var modalOff = $('.unlockable-modal').offset()

            var Spacing = (PuzzlePieceWidth * 2.00);
            var gutter = (innerWidth - modalW) / 2
 
            //TOP
            for(i = 0; i < PiecesPerSide + 1; i++){
                PuzzleChunks[j++].MoveTo(gutter + spacing(i), 44); 
            }

            //BOTTOM
            for(i = 0; i < PiecesPerSide + 1; i++){
                PuzzleChunks[j++].MoveTo(gutter + spacing(i), modalH - (PuzzlePieceHeight * 0.38));
            }

            //LEFT
            Spacing = PuzzlePieceHeight/2;
            for(i = 0; i < PiecesPerSide; i++){
                //PuzzleChunks[j++].MoveTo(gutter + jag(j), Spacing * (i+1)); 
                PuzzleChunks[j++].MoveTo(gutter - (PuzzlePieceWidth * 0.15), 235); 
            }

            //RIGHT - REMAINING CHUNKS
            var Remainder = PuzzleChunks.length - j;

            Spacing = PuzzlePieceHeight/2;

            for(i = 0; i < Remainder; i++){
                PuzzleChunks[j++].MoveTo((gutter + modalW - (PuzzlePieceWidth * 0.90)), 235);
            }

            /*
            console.log("modalH: " + modalH + " modalW: " + modalW + " left: " + modalOff.left + " top: " + modalOff.top);
            console.log("gutter:              " + gutter);
            console.log("PiecesPerSide:       " + PiecesPerSide);
            console.log("PuzzleChunks.length: " + PuzzleChunks.length);
            console.log("Remainder:           " + Remainder);
            console.log("FrameWidth:          " + FrameWidth);
            console.log("PuzzlePieceWidth:    " + PuzzlePieceWidth);
            */
        }

        function Update(){
            if(bGameStarted){
                var bFoundSnapTarget = false;
                var DistanceLimit = (PuzzlePieceWidth*PuzzlePieceWidth) * 1.8;
                var ClosestDistance = DistanceLimit;
                for(var i = 0; i < PuzzleChunks.length; i++){
                    PuzzleChunks[i].Update();
                    if(hCurrentDrag !== null && PuzzleChunks[i] != hCurrentDrag){
                        for(var j = 0; j < PuzzleChunks[i].Pieces.length; j++){
                            var TestPiece = PuzzleChunks[i].Pieces[j];
                            for(var k = 0; k < hCurrentDrag.Pieces.length; k++){
                                var DragPiece = hCurrentDrag.Pieces[k];
                                var CurrentDistance = SqDistance(DragPiece.X, DragPiece.Y, TestPiece.X, TestPiece.Y );
                                if( CurrentDistance < DistanceLimit){
                                    //Find nearest side! Airthmatic is always fastest
                                    var OffsetX = TestPiece.X - DragPiece.X;
                                    var OffsetY = TestPiece.Y - DragPiece.Y;
                                    //TODO - OPTIMIZE SLIGHTLY
                                    var DistanceX = Math.abs(OffsetX);
                                    var DistanceY = Math.abs(OffsetY);
                                    var DistanceToNearestEdge = 0;
                                    if( DistanceX > DistanceY){
                                        //We're off to the sides
                                        if(OffsetX > 0 && TestPiece.connections[Snap.LEFT] != hPuzzlePieceDummy){
                                            DistanceToNearestEdge = Math.abs(TestPiece.X - (DragPiece.X + PuzzlePieceWidth));
                                            if(DistanceToNearestEdge < ClosestDistance){
                                                ClosestDistance = DistanceToNearestEdge;
                                                bFoundSnapTarget = true;
                                                hSnapTarget = TestPiece;
                                                SnapOriginIndex = k;
                                                SideToSnap = Snap.LEFT;
                                            }
                                        }else if(TestPiece.connections[Snap.RIGHT] != hPuzzlePieceDummy){
                                            DistanceToNearestEdge = Math.abs((TestPiece.X + PuzzlePieceWidth) - DragPiece.X);
                                            if(DistanceToNearestEdge < ClosestDistance){
                                                ClosestDistance = DistanceToNearestEdge;
                                                bFoundSnapTarget = true;
                                                hSnapTarget = TestPiece;
                                                SnapOriginIndex = k;
                                                SideToSnap = Snap.RIGHT;
                                            }
                                        }
                                    }else{
                                        //Vertically
                                        if(OffsetY > 0 && TestPiece.connections[Snap.TOP] != hPuzzlePieceDummy){
                                            DistanceToNearestEdge = Math.abs(TestPiece.Y - (DragPiece.Y + PuzzlePieceHeight));
                                            if(DistanceToNearestEdge < ClosestDistance){
                                                ClosestDistance = DistanceToNearestEdge;
                                                bFoundSnapTarget = true;
                                                hSnapTarget = TestPiece;
                                                SnapOriginIndex = k;
                                                SideToSnap = Snap.TOP;
                                            }
                                        }else if(TestPiece.connections[Snap.BOTTOM] != hPuzzlePieceDummy){
                                            DistanceToNearestEdge = Math.abs((TestPiece.Y + PuzzlePieceHeight) - DragPiece.Y);
                                            if(DistanceToNearestEdge < ClosestDistance){
                                                ClosestDistance = DistanceToNearestEdge;
                                                bFoundSnapTarget = true;
                                                hSnapTarget = TestPiece;
                                                SnapOriginIndex = k;
                                                SideToSnap = Snap.BOTTOM;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                if(!bFoundSnapTarget){
                    hSnapTarget = null;
                }
            }
        }

        function Render() {
            hBackRC.clearRect(0,0,FrameWidth,FrameHeight);
            hRC.clearRect(0,0,FrameWidth,FrameHeight);

            //Draw Shadows
            //TODO - Think about this
            hBackRC.beginPath();
            var i = 0;
            var j = 0;
            var CurrentChunk = null;
            var CurrentPiece = null;
            for(i = 0; i < PuzzleChunks.length; i++){
                CurrentChunk = PuzzleChunks[i];
                for(j = 0; j < CurrentChunk.Pieces.length; j++){
                    CurrentPiece = CurrentChunk.Pieces[j];
                    //hBackRC.drawImage(hShadowImage, CurrentPiece.X + 5, CurrentPiece.Y + 5);
                    var ShLeft = CurrentPiece.X;
                    var ShRight = ShLeft + PuzzlePieceWidth;
                    var ShTop = CurrentPiece.Y;
                    var ShBottom = ShTop + PuzzlePieceHeight;
                    hBackRC.moveTo(ShLeft, ShBottom);
                    hBackRC.lineTo(ShRight, ShBottom);
                    hBackRC.lineTo(ShRight, ShTop);
                }
            }
            //hBackRC.closePath();
            hBackRC.lineWidth = 10;
            hBackRC.strokeStyle = "rgba(0, 0, 0, 0.15)";
            hBackRC.stroke();

            hBackRC.lineWidth = 8;
            hBackRC.strokeStyle = "rgba(0, 0, 0, 0.15)";
            hBackRC.stroke();

            hBackRC.lineWidth = 6;
            hBackRC.strokeStyle = "rgba(0, 0, 0, 0.15)";
            hBackRC.stroke();

            hBackRC.lineWidth = 4;
            hBackRC.strokeStyle = "rgba(0, 0, 0, 0.25)";
            hBackRC.stroke();
            //Draw border around hover targets
            if(hCurrentHover !== null){
                hBackRC.beginPath();
                for(var h = 0; h < hCurrentHover.length; h++){
                    var Piece = hCurrentHover[h];
                    var BLeft = Piece.X - 1;
                    var BUp = Piece.Y - 1;
                    hBackRC.moveTo(BLeft, BUp);
                    hBackRC.lineTo(Piece.X + PuzzlePieceWidth, BUp);
                    hBackRC.lineTo(Piece.X + PuzzlePieceWidth, Piece.Y + PuzzlePieceHeight);
                    hBackRC.lineTo(BLeft, Piece.Y + PuzzlePieceHeight);
                    hBackRC.lineTo(BLeft, BUp);
                    hBackRC.closePath();
                }
                //hBackRC.closePath();

                hBackRC.lineWidth = 6;
                hBackRC.strokeStyle = "#FFFF00";
                hBackRC.stroke();
            }

            for(i = 0; i < PuzzleChunks.length; i++){
                CurrentChunk = PuzzleChunks[i];
                for(j = 0; j < CurrentChunk.Pieces.length; j++){
                    CurrentPiece = CurrentChunk.Pieces[j];
                    hBackRC.drawImage(VideoSRC,CurrentPiece.srcX,CurrentPiece.srcY,PuzzlePieceWidth,PuzzlePieceHeight, Math.floor(CurrentPiece.X),Math.floor(CurrentPiece.Y),PuzzlePieceWidth,PuzzlePieceHeight);
                }
            }
            if(hSnapTarget !== null){
                hBackRC.beginPath();
                var Ax = hSnapTarget.GetEdgeCenterX(SideToSnap);
                var Ay = hSnapTarget.GetEdgeCenterY(SideToSnap);
                var Bx = 0;
                var By = 0;
                hBackRC.arc(Ax, Ay, 10, 0 , 2 * Math.PI, false);
                switch(SideToSnap){
                case Snap.TOP:
                    Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.BOTTOM);
                    By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.BOTTOM);
                    break;
                case Snap.BOTTOM:
                    Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.TOP);
                    By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.TOP);
                    break;
                case Snap.RIGHT:
                    Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.LEFT);
                    By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.LEFT);
                    break;
                case Snap.LEFT:
                    Bx = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterX(Snap.RIGHT);
                    By = hCurrentDrag.Pieces[SnapOriginIndex].GetEdgeCenterY(Snap.RIGHT);
                    break;
                }
                hBackRC.arc(Bx, By, 10, 0 , 2 * Math.PI, false);
                hBackRC.closePath();
                hBackRC.fillStyle = 'blue';
                hBackRC.fill();

                hBackRC.beginPath();
                hBackRC.moveTo(Ax, Ay);
                hBackRC.lineTo(Bx,By);
                hBackRC.lineWidth = "2";
                hBackRC.strokeStyle = "#9999FF";
                hBackRC.stroke();
            }

            //hBackRC.restore();
            // if(bWonGame){
            //     hBackRC.font="40pt sans-serif";
            //     hBackRC.fillStyle = "#FFFFFF";
            //     hBackRC.strokeStyle = 'black';
            //     hBackRC.strokeText("SUCCESS!", 200, 200);
            //     hBackRC.fillText("SUCCESS!", 200, 200);

            //     var strTimeWon = "Completed in " + nPlayerTime / 1000 + " seconds";
            //     hBackRC.strokeText(strTimeWon, 200, 300);
            //     hBackRC.fillText(strTimeWon, 200, 300);
            // }else if(bLostGame){
            //     hBackRC.font="40pt sans-serif";
            //     hBackRC.fillStyle = "#FFFFFF";
            //     hBackRC.strokeStyle = 'black';
            //     hBackRC.strokeText("Game Over", 200, 200);
            //     hBackRC.fillText("Game Over", 200, 200);

            //     var strProgress = "You made " + nConnectedPieces + " out of " + (TotalPuzzlePieces-1) + " connections";
            //     //var strProgress = "You connected " + Math.floor((nConnectedPieces/TotalPuzzlePieces) * 100.0) + "% of the puzzle";
            //     hBackRC.strokeText(strProgress, 200, 300);
            //     hBackRC.fillText(strProgress, 200, 300);
            // }
            hRC.drawImage(hBackBuffer,0,0,FrameWidth,FrameHeight);
        }
        function bindEvents(){
            var frontbuffer = $('#maincanvas');
            frontbuffer.mousedown( mouseDown);
            frontbuffer.mouseup( mouseUp);
            frontbuffer.mousemove( mouseMove);

        }


        function startgame(){
            PrepareContainer(3, 2)
            initPuzzle()
            startVideo()
            beginGame()
            observer.video_refresh_interval = vidRenderInterval

        }
        if (videotag.readyState == 0){
            videotag.addEventListener("loadedmetadata",startgame)
        } else {
            startgame()
        }


    }
    return {
        'JPuzzle':JPuzzle
    }
})
