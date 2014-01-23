define(['ember'], function(Ember){Ember.TEMPLATES["FrameRound"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashTypes, hashContexts, self=this, escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = '', stack1, hashTypes, hashContexts;
  data.buffer.push("\n      ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "attempt", {hash:{},inverse:self.program(4, program4, data),fn:self.program(2, program2, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n    ");
  return buffer;
  }
function program2(depth0,data) {
  
  
  data.buffer.push("\n        <li class=\"lock success\"></li>\n      ");
  }

function program4(depth0,data) {
  
  
  data.buffer.push("\n        <li class=\"lock fail\"></li>\n      ");
  }

function program6(depth0,data) {
  
  var buffer = '', stack1, hashContexts, hashTypes;
  data.buffer.push("\n      <li class=\"initial-frame-item\">\n        ");
  hashContexts = {'frameBinding': depth0};
  hashTypes = {'frameBinding': "STRING"};
  stack1 = helpers.view.call(depth0, "Unlockable.DropFrameView", {hash:{
    'frameBinding': ("this")
  },inverse:self.noop,fn:self.program(7, program7, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n      </li>\n    ");
  return buffer;
  }
function program7(depth0,data) {
  
  var buffer = '', stack1, hashContexts, hashTypes;
  data.buffer.push("\n          ");
  hashContexts = {'frameBinding': depth0};
  hashTypes = {'frameBinding': "STRING"};
  stack1 = helpers.view.call(depth0, "Unlockable.DragFrameView", {hash:{
    'frameBinding': ("this")
  },inverse:self.noop,fn:self.program(8, program8, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n        ");
  return buffer;
  }
function program8(depth0,data) {
  
  var buffer = '', hashContexts, hashTypes;
  data.buffer.push("\n            <img ");
  hashContexts = {'src': depth0};
  hashTypes = {'src': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'src': ("view.image")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("/>\n          ");
  return buffer;
  }

function program10(depth0,data) {
  
  var buffer = '', stack1, hashContexts, hashTypes;
  data.buffer.push("\n      <li class=\"ending-frame-item\">\n        ");
  hashContexts = {'frameBinding': depth0};
  hashTypes = {'frameBinding': "STRING"};
  stack1 = helpers.view.call(depth0, "Unlockable.DropFrameView", {hash:{
    'frameBinding': ("frame")
  },inverse:self.noop,fn:self.program(11, program11, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n      </li>\n    ");
  return buffer;
  }
function program11(depth0,data) {
  
  var buffer = '', stack1, hashContexts, hashTypes;
  data.buffer.push("\n          ");
  hashContexts = {'frameBinding': depth0};
  hashTypes = {'frameBinding': "STRING"};
  stack1 = helpers.view.call(depth0, "Unlockable.DragFrameView", {hash:{
    'frameBinding': ("frame")
  },inverse:self.noop,fn:self.program(12, program12, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n        ");
  return buffer;
  }
function program12(depth0,data) {
  
  var buffer = '', hashContexts, hashTypes;
  data.buffer.push("\n            <img ");
  hashContexts = {'src': depth0};
  hashTypes = {'src': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'src': ("view.image")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" />\n          ");
  return buffer;
  }

  data.buffer.push("<div class=\"unlockable-screen frames-round-screen\">\n  <ul class=\"attempts\">\n    ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers.each.call(depth0, "attempt", "in", "Unlockable.router.framesController.attempts", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0,depth0,depth0],types:["ID","ID","ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n  </ul>\n  <ul class=\"initial-frames-list\">\n    ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers.each.call(depth0, "Unlockable.router.givenFramesController", {hash:{},inverse:self.noop,fn:self.program(6, program6, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n  </ul>\n  <ul class=\"ending-frames-list\">\n    ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers.each.call(depth0, "frame", "in", "Unlockable.router.playFramesController", {hash:{},inverse:self.noop,fn:self.program(10, program10, data),contexts:[depth0,depth0,depth0],types:["ID","ID","ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n  </ul>\n</div>\n\n<a ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "next", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" ");
  hashContexts = {'class': depth0};
  hashTypes = {'class': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'class': (":base-btn :next hasPlaced::disabled")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">SUBMIT</a>\n");
  return buffer;
  
});
Ember.TEMPLATES["Frames"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', hashContexts, hashTypes, escapeExpression=this.escapeExpression;


  data.buffer.push("<div ");
  hashContexts = {'class': depth0};
  hashTypes = {'class': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'class': ("timer-display")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "timer", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</div>\n\n");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "outlet", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n");
  return buffer;
  
});
Ember.TEMPLATES["FramesCommercial"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashContexts, hashTypes, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = '', hashTypes, hashContexts;
  data.buffer.push("\n    <a ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "commercialFinished", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" style=\"float:right;font-weight:bold;color:blue;\"> SKIP (development) </a>\n  ");
  return buffer;
  }

  data.buffer.push("<div class=\"unlockable-screen frames-commercial-screen\">\n  ");
  hashContexts = {'sourcesBinding': depth0};
  hashTypes = {'sourcesBinding': "STRING"};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.CommercialView", {hash:{
    'sourcesBinding': ("content")
  },contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n  ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "Unlockable.debug", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n\n</div>");
  return buffer;
  
});
Ember.TEMPLATES["FramesInstructions"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', hashTypes, hashContexts, escapeExpression=this.escapeExpression;


  data.buffer.push("<div class=\"unlockable-screen frames-instructions-screen\">\n  <div class=\"banner instructions\">Instructions</div>\n  <h1 class=\"headline\">Sort 'Em</h1>\n  <h4 class=\"descriptor\">Watch the video and sort the photos into the correct timeline</h4>\n  <div class=\"instructions-image-wrapper\">\n    <div class=\"instructions-tile-image\"></div>\n  </div>\n</div>\n\n<a ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "watchCommercial", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" class=\"base-btn start\">Start</a>");
  return buffer;
  
});
Ember.TEMPLATES["FramesPerformance"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashContexts, hashTypes, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  
  data.buffer.push("\n            <td class=\"max\">MAX!</td>\n          ");
  }

  data.buffer.push("<div ");
  hashContexts = {'class': depth0};
  hashTypes = {'class': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'class': ("starClass")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">\n\n  <div ");
  hashContexts = {'data-stars': depth0,'class': depth0};
  hashTypes = {'data-stars': "STRING",'class': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'data-stars': ("Unlockable.router.framesController.stars"),
    'class': (":unlockable-screen :complete-screen")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">\n    <div class=\"banner complete\"><span class=\"gameName\">SORT 'EM</span><br>COMPLETE!</div>\n    <ul class=\"stars\">\n      <li class=\"star star-1 fadeInUp\"></li>\n      <li class=\"star star-2 fadeInUp\"></li>\n      <li class=\"star star-3 fadeInUp\"></li>\n    </ul>\n    <h1 class=\"headline\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.framesController.score", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</h1>\n    <table class=\"descriptor\">\n      <tbody>\n        <tr>\n          <td>ACCURACY</td>\n          <td>+");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.framesController.accuracyPoints", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</td>\n        </tr>\n        <tr>\n          <td>TIME</td>\n          <td>+");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.framesController.timePoints", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</td>\n          ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "Unlockable.router.framesController.gotMaxTimePoints", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n        </tr>\n      </tbody>\n    </table>\n    <div class=\"scorebar-wrapper\">\n      <div class=\"webkit-radius-fix-scorebar\"></div>\n      <div class=\"scorebar\">\n        <div class=\"scoreText\">\n          <span class=\"acquired\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.currentPlayerController.points", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</span>\n          <span> / </span>\n          <span class=\"totalAvailable\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.pointsNeeded", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</span></div>\n          ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.ScoreMercury", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n      </div>\n    </div>\n  </div>\n\n  <a class=\"base-btn next\" ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "doneWithGame", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("> NEXT </a>\n\n  <div class=\"robot\"></div>\n\n  ");
  hashContexts = {'contentBinding': depth0};
  hashTypes = {'contentBinding': "STRING"};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.OfferWindowView", {hash:{
    'contentBinding': ("Unlockable.router.framesController")
  },contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n\n  <div class=\"prize\">\n    <div class=\"coinstack\"></div>\n    <div class=\"lock\">\n      <div class=\"lock-top\"></div>\n      <div class=\"lock-bottom\"></div>\n    </div>\n  </div>\n\n</div>\n");
  return buffer;
  
});
})