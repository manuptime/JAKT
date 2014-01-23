
// http://paulirish.com/2011/requestanimationframe-for-smart-animating/
// http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating

// requestAnimationFrame polyfill by Erik Möller
// fixes from Paul Irish and Tino Zijdel

define(['ember', '_', 'cs!unlockable/unlockable', 'cs!dropblocks/models'], function(Em, _, Unlockable, Models) {

(function() {
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
        window.cancelAnimationFrame = window[vendors[x]+'CancelAnimationFrame']
                                   || window[vendors[x]+'CancelRequestAnimationFrame'];
    }

    if (!window.requestAnimationFrame)
        window.requestAnimationFrame = function(callback, element) {
            var currTime = new Date().getTime();
            var timeToCall = Math.max(0, 16 - (currTime - lastTime));
            var id = window.setTimeout(function() { callback(currTime + timeToCall); },
              timeToCall);
            lastTime = currTime + timeToCall;
            return id;
        };

    if (!window.cancelAnimationFrame)
        window.cancelAnimationFrame = function(id) {
            clearTimeout(id);
        };
}());


var arrayUtils = {};

arrayUtils.Randomize = function( myArray ) {
  var i = myArray.length;
  if ( i === 0 ) return false;
    while ( --i ) {
        var j = Math.floor( Math.random() * ( i + 1 ) );
        var tempi = myArray[i];
        var tempj = myArray[j];
        myArray[i] = tempj;
        myArray[j] = tempi;
    }
};

arrayUtils.removeElement = function(i, array){
    var lastIndex = array.length - 1;
    if(i != lastIndex){
        array[i] = array[lastIndex];
    }
    array.pop();
};

var dropblocksScene = {};

dropblocksScene.maxBlockBlur = 3;

dropblocksScene.occupiedSlots = [];
dropblocksScene.blockList = [];
dropblocksScene.currentRowOrder = [];
dropblocksScene.currentColumn = 0;
dropblocksScene.currentRow = 0;

dropblocksScene.blockWidth = 125;
dropblocksScene.blockHeight = 125;
dropblocksScene.piecesWidth = 0;
dropblocksScene.piecesHeight = 0;

dropblocksScene.leftBound = 0;
dropblocksScene.rightBound = 0;
dropblocksScene.topBound = 0;
dropblocksScene.bottomBound = 0;

dropblocksScene.pieceCount = 0;
dropblocksScene.blurEmissionInterval = 0.01;

dropblocksScene.referenceTiles = 2;
dropblocksScene.tileCounter = 0;
dropblocksScene.tilesPlayed = 0;

dropblocksScene.flags = [];

    dropblocksScene.startNewRow = function(){
    arrayUtils.Randomize(dropblocksScene.currentRowOrder);
    dropblocksScene.currentColumn = 0;
    dropblocksScene.currentRow--;
};

	dropblocksScene.initialize = function(width, height, observer){

    //console.log('dropblocksScene Renderer');
    //console.log(Renderer);

	//console.log('dropblocksScene Renderer.video.height')
	//console.log(Renderer.video.height)

	//console.log('dropblocksScene Renderer.video.width')
	//console.log(Renderer.video.width)
	dropblocksScene.observer = observer;

    dropblocksScene.totalPieces = width * height;

    dropblocksScene.piecesWidth = width;    // how many horizontal pieces
    dropblocksScene.piecesHeight = height;  // how many vertical pieces

    dropblocksScene.blockWidth = (Renderer.video.width / dropblocksScene.piecesWidth) * Renderer.videoSizeMultiplier;
    dropblocksScene.blockHeight = (Renderer.video.height / dropblocksScene.piecesHeight) * Renderer.videoSizeMultiplier;

    Renderer.playAreaHeight += dropblocksScene.blockHeight * 2;

    dropblocksScene.rightBound = Renderer.playAreaX + Renderer.playAreaWidth - dropblocksScene.blockWidth;
    dropblocksScene.bottomBound = Renderer.playAreaY + Renderer.playAreaHeight - dropblocksScene.blockHeight;
    for(var x = 0; x < width; x++){
        for(var y = 0; y < height; y++){
            dropblocksScene.occupiedSlots.push(0);
            dropblocksScene.flags.push(0);
        }
    }

	//console.log('dropblocksScene.occupiedSlots init');
	//console.log(dropblocksScene.occupiedSlots);

    for(var i = 0; i < dropblocksScene.piecesWidth; i++){
        dropblocksScene.currentRowOrder.push(i);
    }

    dropblocksScene.startNewRow();
    dropblocksScene.currentRow = dropblocksScene.piecesHeight-1;
	};

dropblocksScene.block = function(X,Y){

    this.gridX = X;

    this.X = X * dropblocksScene.blockWidth;
    this.Y = Y;
    //console.log('dropblocksScene.block this.Y = ' + Y) Y is always 0?
    this.bNeedsUpdate = true;

    this.column = dropblocksScene.currentRowOrder[dropblocksScene.currentColumn];
    this.srcX = this.column * Renderer.adjustedLookupWidth;
    this.srcY = dropblocksScene.currentRow * Renderer.adjustedLookupHeight;

    this.targetX = this.X;
    this.bBoost = false;
    this.blurTimer = 0;
};

dropblocksScene.dropNewBlock = function(){
    if(dropblocksScene.pieceCount++ < dropblocksScene.totalPieces){
        dropblocksScene.currentBlock = new dropblocksScene.block(Math.floor(Math.random() * dropblocksScene.piecesWidth),0);
        dropblocksScene.blockList.push(dropblocksScene.currentBlock);

        if(dropblocksScene.tileCounter++ < dropblocksScene.referenceTiles){
            dropblocksScene.currentBlock.X = dropblocksScene.currentBlock.column * dropblocksScene.blockWidth;
            dropblocksScene.currentBlock.Y = (dropblocksScene.currentRow+2) * dropblocksScene.blockHeight;
            dropblocksScene.currentBlock.bNeedsUpdate = false;

            dropblocksScene.occupiedSlots[dropblocksScene.currentBlock.column + dropblocksScene.currentRow * dropblocksScene.piecesWidth] = 1; //this is correct

                // dump 3x3 occupiedSlots
                var out = '';
                //console.log('Drop new block');
                for(var y = 0; y < dropblocksScene.piecesHeight; y++){
                   for(var x = 0; x < dropblocksScene.piecesWidth; x++){
                       out = out + dropblocksScene.occupiedSlots[x + 3*y].toString();  // is there a better way?
                       //console.log(x + ' ' + y + ' ==> ' + dropblocksScene.occupiedSlots[x + 3*y]);
                   }
				   //console.log('      ' + out);
				   out = '';
                   }


            dropblocksScene.flags[dropblocksScene.currentBlock.column + dropblocksScene.currentRow * dropblocksScene.piecesWidth] = 1;

            if(++dropblocksScene.currentColumn >= dropblocksScene.piecesWidth ){
                dropblocksScene.startNewRow();
            }
            dropblocksScene.dropNewBlock();
        }
    }
};

dropblocksScene.floatyPopup = function(src){
    //console.log('floatyPopup this.Y = 0')
    this.X = 0;
    this.Y = 0;
    this.Lifetime = 2.0;

    this.image = new Image();
    this.image.src = src;
};

dropblocksScene.floatyPopup.prototype.place = function(x,y){
    //console.log('floatyPopup.prototype.place this.Y = ' + y)
    this.X = x;
    this.Y = y;
    this.Lifetime = 2.0;
    this.bRender = true;
};

dropblocksScene.floatyPopup.prototype.update = function(){
    //console.log('floatyPopup.prototype.update this.Y = ' + this.Y + ' subtract: ' + Time.secondsSinceLastFrame * 10)
    this.Y -= Time.secondsSinceLastFrame * 10;
    //console.log('floatyPopup.prototype.update this.Y = ' + this.Y)
    this.Lifetime -= Time.secondsSinceLastFrame;
    if(this.Lifetime <= 0){
        this.bRender = false;
    }
};


//  0,0  1,0  2,0
//  0,1  1,1  2,1
//  0,2  1,2  2,2

// 0 1 2
// 1 2 3
// 2 3 4


//       X             Y
// 0 = 0           0 = 187.5
// 1 = 166.66...   1 = 281.25
// 2 = 333.33...   2 = 375


// looks like when a block is placed properly but scored wrong the problem is an
// incorrect this.Y, this.Y is low by 93.75, which is one dropblocksScene.blockHeight below
dropblocksScene.block.prototype.batonPass = function(){
    this.X = this.targetX;

    var temp = (this.Y + 5) / dropblocksScene.blockHeight;
    //console.log('floor(' + temp + ')-2       ' + this.X + ',' + this.Y)

    var yCoord = Math.floor((this.Y+5) / dropblocksScene.blockHeight)-2; // these mystery constants might be the problem

    //debugger;

    //console.log('gridX: ' + this.gridX  + ' column: ' + this.column + '  OR  yCoord: ' + yCoord + ' currentRow: ' + dropblocksScene.currentRow);
    //console.log('Move: ' + this.gridX  + ',' + yCoord + '  Answer: ' + this.column + ',' + dropblocksScene.currentRow);

    if(this.gridX != this.column || yCoord != dropblocksScene.currentRow){
        //WRONG ANSWER
        //console.log('                                                             WRONG WRONG WRONG WRONG WRONG');
        Renderer.addBlurParticle(this.X, this.Y, true,'rgb(255,0,0)');
        dropblocksScene.bigX.place(this.X, this.Y);
        this.gridX = this.column;
        yCoord = dropblocksScene.currentRow;
        this.X = this.gridX * dropblocksScene.blockWidth;
        this.Y = (yCoord + 2) * dropblocksScene.blockHeight;
        dropblocksScene.tilesPlayed++;
    }
    else
	{
		dropblocksScene.tilesPlayed++;
        if (dropblocksScene.tilesPlayed < 8) {
            //console.log('                                                             RIGHT RIGHT RIGHT RIGHT RIGHT');
            dropblocksScene.observer.connected();
		}
	}

    //console.log('                                                             Tiles played: ' + dropblocksScene.tilesPlayed);
    if (dropblocksScene.tilesPlayed == 7)
	{
        dropblocksScene.observer.wonGame();
	}

    dropblocksScene.occupiedSlots[this.gridX + yCoord * dropblocksScene.piecesWidth] = 1; // looks correct
    index = this.gridX + yCoord * dropblocksScene.piecesWidth;
    //console.log('dropblocksScene.occupiedSlots[' + index + '] = 1');
    this.bNeedsUpdate = false;

    if(++dropblocksScene.currentColumn >= dropblocksScene.piecesWidth ){
        dropblocksScene.startNewRow();
    }

    dropblocksScene.dropNewBlock();
};

dropblocksScene.block.prototype.update = function(){
    if(this.bNeedsUpdate){
        var Velocity = 15.0;
        if(this.X != this.targetX){
            this.X = gameMath.Lerp(this.X, this.targetX, 20.9 * Time.secondsSinceLastFrame);
            if(Math.abs(this.X - this.targetX) < 1){
                this.X = this.targetX;
            }
        }else if(this.bBoost){
            Velocity *= 40;
            this.blurTimer += Time.secondsSinceLastFrame;
            if(this.blurTimer >= dropblocksScene.blurEmissionInterval){
                Renderer.addBlurParticle(this.X, this.Y, true,'rgb(100,100,255)');
                this.blurTimer = 0;
            }
        }

        this.Y += Velocity * Time.secondsSinceLastFrame;

        if(this.Y >= dropblocksScene.bottomBound){
            this.Y = dropblocksScene.bottomBound;
            //console.log('this.Y = dropblocksScene.bottomBound ' + this.Y)
            //console.log(dropblocksScene.occupiedSlots); // all zeros, after first piece is placed, game chosen opening pieces show up in array
            index = xCoordBelow + yCoordBelow * dropblocksScene.piecesWidth;
            //console.log('dropblocksScene.occupiedSlots[' + index + ']');
            this.batonPass();
        }else{ // piece is moving down
            var yFactor = Math.floor(this.Y / dropblocksScene.blockHeight);
            //var yFactor = this.Y / dropblocksScene.blockHeight; every move is wrong without floor()
            ////console.log('yFactor this.Y ' + this.Y)
            var xCoordBelow = Math.floor(this.targetX / dropblocksScene.blockWidth);
            var yCoordBelow = yFactor - 1;


            // nothing here seems to check if position is correct, maybe targetX?

            X = Math.floor(this.X / dropblocksScene.blockWidth);  // these are the coordinates of the last position of a move when it is judged
            Y = Math.floor(this.Y / dropblocksScene.blockHeight); // this is an experiment



            //if(yCoordBelow >= 0 && dropblocksScene.occupiedSlots[dropblocksScene.currentBlock.column + dropblocksScene.currentRow * dropblocksScene.piecesWidth] !== 0){  // 1 is occupied all moves wrong

            // THIS LOOKS LIKE THE OFFENDING LINE BELOW, I THINK occupiedSlots INDEX IS WRONG
            if(yCoordBelow >= 0 && dropblocksScene.occupiedSlots[xCoordBelow + yCoordBelow * dropblocksScene.piecesWidth] !== 0){  // 1 is occupied
                //console.log('Below: ' + xCoordBelow + ',' + yCoordBelow);
            //if(yCoordBelow >= 0 && dropblocksScene.occupiedSlots[X + Y * dropblocksScene.piecesWidth] !== 0){  // all moves wrong
                //this.flags[X][Y] = 1;
                //console.log('X,Y = ' + X + ',' + Y);
                //console.log(this.flags);

                //console.log('   0  1  2  3  4  5  6  7  8');
                //console.log(dropblocksScene.occupiedSlots);

                // dump 3x3 occupiedSlots
                var out = '';
                //console.log('Piece has been played');
                for(var y = 0; y < dropblocksScene.piecesHeight; y++){
                   for(var x = 0; x < dropblocksScene.piecesWidth; x++){
                       out = out + dropblocksScene.occupiedSlots[x + 3*y].toString();  // is there a better way?
                       //console.log(x + ' ' + y + ' ==> ' + dropblocksScene.occupiedSlots[x + 3*y]);
                   }
				   //console.log('      ' + out);
				   out = '';
                   }

                // dump index info from if( ... occupiedSlots above), this index is sometimes wrong because it repeats in a single game
                index = xCoordBelow + yCoordBelow * dropblocksScene.piecesWidth;
                //console.log('if dropblocksScene.occupiedSlots[' + index + '] !== 0');
                var checkHeight = yFactor*dropblocksScene.blockHeight;
                //console.log('checkHeight: ' + checkHeight + ' yCoordBelow: ' + yCoordBelow);

                if(this.Y + dropblocksScene.blockHeight >= checkHeight){
                    this.Y = checkHeight;
                    //console.log('this.Y = checkHeight ' + this.Y);
                    this.batonPass();
                }else{
                    //not reached
                    //console.log('not low enough yet: ' + checkHeight);
				}
            }
        }
    }
};



var Dropblocks = {};

Dropblocks.startGame = function(videotag, observer){
    //Let 'er rip

    // added here since DOMContentLoaded seems to not be happening
    dropblocksScene.bigX = new dropblocksScene.floatyPopup(Unlockable.cdn + '/media/img/bigX.png');
    Renderer.initialize(document.getElementById('maincanvas-dropblocks'), videotag, observer);
};

Dropblocks.update = function(){
    if(Dropblocks.gameRunning){
        requestAnimationFrame(Dropblocks.update);
        Time.advance();
        //Update things
        Renderer.drawScene();
    }
};

Dropblocks.endGame = function(){
    Dropblocks.gameRunning = false;
    //cancelAnimationFrame(Dropblocks.frameQueue);
};

window.addEventListener("keyup", function(ev){
    if(dropblocksScene.currentBlock){
        switch(ev.keyCode){
            case 40:
                dropblocksScene.currentBlock.bBoost = false;
                break;
            default:
                break;
        }
    }
});

window.addEventListener("keydown", function(ev){
    //alert(ev.keyCode);
    if(dropblocksScene.currentBlock){
        var nextX = 0;
        switch(ev.keyCode){
            // case 38:{ // UP
            //     dropblocksScene.addBlurParticle(dropblocksScene.currentBlock.X, dropblocksScene.currentBlock.Y);
            // }
            // break;
            case 37:{ // LEFT
                nextX = dropblocksScene.currentBlock.targetX - dropblocksScene.blockWidth;

                if(nextX < dropblocksScene.leftBound){
                    nextX = dropblocksScene.leftBound;
                    dropblocksScene.currentBlock.gridX = 0;
                }else{
                     //Check for block collision to the right
                    var xCoord = dropblocksScene.currentBlock.gridX - 1;

                    var yCoord = Math.floor( (dropblocksScene.currentBlock.Y + dropblocksScene.blockHeight) / dropblocksScene.blockHeight) - 2;
                    if(yCoord >= 0 && xCoord >= 0 && dropblocksScene.occupiedSlots[xCoord + yCoord * dropblocksScene.piecesWidth] !== 0){
                        nextX = dropblocksScene.currentBlock.targetX;
                    }else{
                        dropblocksScene.currentBlock.gridX--;
                    }
                }

                dropblocksScene.currentBlock.targetX = nextX;
            }
                break;
            case 39:{ // RIGHT arrow
                nextX = dropblocksScene.currentBlock.targetX + dropblocksScene.blockWidth;
                if(nextX > dropblocksScene.rightBound){
                    nextX = dropblocksScene.rightBound;
                    dropblocksScene.currentBlock.gridX = dropblocksScene.piecesWidth - 1;
                }else{
                    //Check for block collision to the right
                    var xCoord = dropblocksScene.currentBlock.gridX + 1;

                    var yCoord = Math.floor( (dropblocksScene.currentBlock.Y + dropblocksScene.blockHeight) / dropblocksScene.blockHeight) - 2;
                    if(yCoord >= 0 && xCoord < dropblocksScene.piecesWidth && dropblocksScene.occupiedSlots[xCoord + yCoord * dropblocksScene.piecesWidth] !== 0){
                        nextX = dropblocksScene.currentBlock.targetX;
                    }else{
                        dropblocksScene.currentBlock.gridX++;
                    }
                }
                dropblocksScene.currentBlock.targetX = nextX;
            }
                break;
            case 40: // DOWN arrow
                dropblocksScene.currentBlock.bBoost = true;
                break;
            default:
                break;
        }
    }
});


var Renderer = {};

    //console.log('dropblocksScene');
    //console.log(dropblocksScene);

	Renderer.initialize = function(hCanvas, videotag, observer){
		//console.log('Render.initialize: videotag');
		//console.log(videotag)
		//console.log('Render.initialize: observer');
		//console.log(observer);
		Renderer.observer = observer;

		Renderer.videoSizeMultiplier = 0.9;
		Renderer.backBuffer = document.createElement('canvas');

		Renderer.video = videotag;

		//console.log('dropRenderer.js: Renderer.video');
		//console.log(Renderer.video);
		//console.log(Renderer.video.height);
 		//console.log(Renderer.video.width);

		//console.log('Renderer.backBuffer');
		//console.log(Renderer.backBuffer);

		//console.log('windowUtils');
		//console.log(windowUtils);

		//console.log('hCanvas');
		//console.log(hCanvas);
		onload = function (event) {
			Renderer.frameWidth = Renderer.backBuffer.width = hCanvas.width = windowUtils.getDocWidth();
			Renderer.frameHeight = Renderer.backBuffer.height = hCanvas.height = windowUtils.getDocHeight();
			Renderer.hFrontRC = hCanvas.getContext('2d');
			Renderer.hRC = Renderer.backBuffer.getContext('2d');

			var PuzW = 3, PuzH = 3;

			Renderer.adjustedpixelWidth = 500;  // scales whole game, 640 gives 413 x 469 game
			Dropblocks.gameRunning = true;


			//console.log('=========================================== Renderer.video.addEventListener');

			// Renderer.videoSizeMultiplier changes game size, does not scale video
			if(Renderer.adjustedpixelWidth){
				Renderer.videoSizeMultiplier = (Renderer.adjustedpixelWidth / Renderer.video.videoWidth);
			}
			Renderer.video.width = Renderer.video.videoWidth;
			Renderer.video.height = Renderer.video.videoHeight;

  			//console.log('dropRenderer Renderer.video.height')
			//console.log(Renderer.video.height)

			//console.log('dropRenderer Renderer.video.width')
			//console.log(Renderer.video.width)

			//var vid = document.getElementById("unlockable-commercial");
  			//console.log('vid.height')
			//console.log(vid.height)

			//console.log('vid.width')
			//console.log(vid.width)

			Renderer.playAreaX = 0;
			Renderer.playAreaY = 0;

			Renderer.playAreaWidth = Renderer.video.width * Renderer.videoSizeMultiplier;
			Renderer.playAreaHeight = Renderer.video.height * Renderer.videoSizeMultiplier;

			dropblocksScene.initialize(PuzW,PuzH,Renderer.observer);

			Renderer.adjustedLookupWidth = Renderer.video.width / dropblocksScene.piecesWidth;
			Renderer.adjustedLookupHeight = Renderer.video.height / dropblocksScene.piecesHeight;

			dropblocksScene.dropNewBlock();

			Renderer.blurImage = document.createElement('canvas');
			Renderer.blurImage.width = Renderer.playAreaWidth / 10;
			Renderer.blurImage.height = Renderer.playAreaHeight / 10;
			Renderer.blurParticleWidth = dropblocksScene.blockWidth / 10;
			Renderer.blurParticleHeight = dropblocksScene.blockHeight / 10;

			Renderer.blurRC =  Renderer.blurImage.getContext('2d');

			Time.PrevTime = Date.now();
			Time.NewTime = Time.PrevTime;
			Dropblocks.update();
			Renderer.video.play();

		};
		Em.run.next(function(){
			Renderer.video.addEventListener("loadedmetadata", onload, false);
		});
	};

Renderer.addBlurParticle = function(X, Y, bIsVertical, color){
    this.blurRC.beginPath();
    this.blurRC.rect(X / 10, Y / 10, this.blurParticleWidth, this.blurParticleHeight);
    this.blurRC.closePath();
    this.blurRC.fillStyle = color;
    this.blurRC.fill();
};

Renderer.drawScene = function(){
    var i = 0;
    //TODO - PREDRAW BACKGROUND

    this.hRC.beginPath();
    this.hRC.rect(0, 0, Renderer.playAreaWidth, Renderer.playAreaHeight);
    this.hRC.closePath();
    var grd = this.hRC.createLinearGradient(0, 0, Renderer.playAreaWidth, Renderer.playAreaHeight);
    // light blue
    grd.addColorStop(0, '#211333');
    // dark blue
    grd.addColorStop(1, '#004C23');
    this.hRC.fillStyle = grd;
    this.hRC.fill();

    //this.hRC.fillStyle = '#102010';
    this.hRC.fill();
    this.hRC.beginPath();

    for(var x = 0; x < dropblocksScene.piecesWidth; x++){
        var lineX = x * dropblocksScene.blockWidth;
        this.hRC.moveTo(lineX,Renderer.playAreaY);
        this.hRC.lineTo(lineX,Renderer.playAreaHeight);
    }

    for(var y = 0; y < dropblocksScene.piecesHeight + 2; y++){
        var lineY = y * dropblocksScene.blockHeight;
        this.hRC.moveTo(Renderer.playAreaX,lineY);
        this.hRC.lineTo(Renderer.playAreaWidth, lineY);
    }

    this.hRC.closePath();
    this.hRC.lineWidth=5;
    this.hRC.strokeStyle="#333333";
    this.hRC.stroke();

    this.hRC.lineWidth=3;
    this.hRC.strokeStyle="#AAAAAA";
    this.hRC.stroke();

    this.hRC.lineWidth=1;
    this.hRC.strokeStyle="#FFFFFF";
    this.hRC.stroke();


    //Blur the blur trails!
    var imgData = this.blurRC.getImageData(0,0,this.blurImage.width,this.blurImage.height);
    // invert colors
    var imgDataEnd = imgData.data.length + 3;
    for (i = 3; i < imgDataEnd ; i+=4){
        var Alpha = imgData.data[i];
        if(Alpha > 0){
            Alpha -= Math.floor(800.0 * Time.secondsSinceLastFrame);
            if(Alpha < 0){
                Alpha = 0;
            }
        }
        imgData.data[i] = Alpha;
    }
    this.blurRC.putImageData(imgData,0,0);

    this.hRC.drawImage(this.blurImage, 0,0, this.blurImage.width, this.blurImage.height, this.playAreaX, this.playAreaY, this.playAreaWidth, this.playAreaHeight);
    for(i = 0; i < dropblocksScene.blockList.length; i++){
        var CurrentPiece = dropblocksScene.blockList[i];
        CurrentPiece.update(); //For a simple game like this, we can update in the render loop just to make the whole thing n complex
        this.hRC.drawImage(Renderer.video,CurrentPiece.srcX,CurrentPiece.srcY,Renderer.adjustedLookupWidth,Renderer.adjustedLookupHeight, CurrentPiece.X,CurrentPiece.Y,dropblocksScene.blockWidth,dropblocksScene.blockHeight);
    }

    if(dropblocksScene.bigX.bRender){
        dropblocksScene.bigX.update();
        this.hRC.drawImage(dropblocksScene.bigX.image, dropblocksScene.bigX.X, dropblocksScene.bigX.Y);
    }
    //Swap to front
    this.hFrontRC.drawImage(this.backBuffer, 0, 0);
};


var gameMath = {};

//Linear Interpolation
gameMath.Lerp = function(a, b, s){
    return b - ((1.0 - s) * (b - a));
};

gameMath.SqDistance = function(Ax, Ay, Bx, By){
    var A = Ax - Bx;
    var B = Ay - By;
    return A*A + B*B;
};

gameMath.Randomize = function( myArray ) {
  var i = myArray.length;
  if ( i === 0 ) return false;
    while ( --i ) {
        var j = Math.floor( Math.random() * ( i + 1 ) );
        var tempi = myArray[i];
        var tempj = myArray[j];
        myArray[i] = tempj;
        myArray[j] = tempi;
    }
};

var Time = Time || {};

Time.elapsedMS = 0;
Time.elapsedSeconds = 0;
Time.msSinceLastFrame = 0;
Time.secondsSinceLastFrame = 0;

Time.advance = function(){
    Time.NewTime = Date.now();
    var ms = Time.NewTime - Time.PrevTime;

    var secondDelta = ms / 1000;
    this.elapsedMS += ms;
    this.elapsedSeconds += secondDelta;

    this.msSinceLastFrame = ms;
    this.secondsSinceLastFrame = secondDelta;
    Time.PrevTime = Time.NewTime;
};

var windowUtils = {};

windowUtils.getDocWidth = function(){
    var D = document;
    return Math.max(
        Math.max(D.body.scrollWidth, D.documentElement.scrollWidth),
        Math.max(D.body.offsetWidth, D.documentElement.offsetWidth),
        Math.max(D.body.clientWidth, D.documentElement.clientWidth)
    );
};


windowUtils.getDocHeight = function(){
    var D = document;
    return Math.max(
        Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
        Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
        Math.max(D.body.clientHeight, D.documentElement.clientHeight)
    );
};

	return {
        'test':12345,
		'startGame':Dropblocks.startGame
	}
})
