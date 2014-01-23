define(['ember'], function(Ember){Ember.TEMPLATES["Dropblocks"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
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
  return buffer;
  
});
Ember.TEMPLATES["DropblocksCommercial"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', hashContexts, hashTypes, escapeExpression=this.escapeExpression;


  data.buffer.push("        ");
  hashContexts = {'sourcesBinding': depth0};
  hashTypes = {'sourcesBinding': "STRING"};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.FooView", {hash:{
    'sourcesBinding': ("content")
  },contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n      <a ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "commercialFinished", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("> START </a>\n");
  return buffer;
  
});
Ember.TEMPLATES["DropblocksGame"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashTypes, hashContexts, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = '', hashTypes, hashContexts;
  data.buffer.push("\n    <a ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "commercialFinished", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" style=\"float:right;font-weight:bold;color:blue;\"> SKIP (development) </a>\n  ");
  return buffer;
  }

  data.buffer.push("<canvas id=\"backcanvas\" style=\"display: none;\"></canvas>\n<canvas id=\"maincanvas-dropblocks\" ></canvas>\n  ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "Unlockable.debug", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n");
  return buffer;
  
});
Ember.TEMPLATES["DropblocksInstructions"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', hashTypes, hashContexts, escapeExpression=this.escapeExpression;


  data.buffer.push("<div class=\"unlockable-screen dropblocks-instructions-screen\">\n  <div class=\"banner instructions\">Instructions</div>\n  <h1 class=\"headline\">Dropblocks</h1>\n  <h4 class=\"descriptor\">Connect pieces using the arrow keys before the video ends!</h4>\n  <div class=\"instructions-image-wrapper\">\n    <div class=\"instructions-tile-image\"></div>\n  </div>\n</div>\n\n<a ");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.action.call(depth0, "watchCommercial", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" class=\"base-btn start\" tab-index=\"1\">Start</a>\n");
  return buffer;
  
});
Ember.TEMPLATES["DropblocksPerformance"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
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
    'data-stars': ("Unlockable.router.dropblocksController.stars"),
    'class': (":unlockable-screen :complete-screen")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">\n    <div class=\"banner complete\"><span class=\"gameName\">DROPBLOCKS</span><br>COMPLETE!</div>\n    <ul class=\"stars\">\n      <li class=\"star star-1 fadeInUp\"></li>\n      <li class=\"star star-2 fadeInUp\"></li>\n      <li class=\"star star-3 fadeInUp\"></li>\n    </ul>\n    <h1 class=\"headline\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.dropblocksController.score", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</h1>\n    <table class=\"descriptor\">\n      <tbody>\n        <tr>\n          <td>ACCURACY</td>\n          <td>+");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.dropblocksController.accuracyPoints", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</td>\n          <td class=\"trys\">");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.dropblocksController.answersRight", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(" correct</td>\n        </tr>\n        <tr>\n          <td>TIME</td>\n          <td>+");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers._triageMustache.call(depth0, "Unlockable.router.dropblocksController.timePoints", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("</td>\n          ");
  hashTypes = {};
  hashContexts = {};
  stack1 = helpers['if'].call(depth0, "Unlockable.router.dropblocksController.gotMaxTimePoints", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
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
  data.buffer.push("> NEXT </a>\n\n  <div class=\"robot\"></div>\n\n\n  ");
  hashContexts = {'contentBinding': depth0};
  hashTypes = {'contentBinding': "STRING"};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.OfferWindowView", {hash:{
    'contentBinding': ("Unlockable.router.dropblocksController")
  },contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n\n  <div class=\"prize\">\n    <div class=\"coinstack\"></div>\n    <div class=\"lock\">\n      <div class=\"lock-top\"></div>\n      <div class=\"lock-bottom\"></div>\n    </div>\n  </div>\n\n</div>\n");
  return buffer;
  
});
Ember.TEMPLATES["DropblocksRound"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', hashContexts, hashTypes, escapeExpression=this.escapeExpression;


  hashContexts = {'sourcesBinding': depth0};
  hashTypes = {'sourcesBinding': "STRING"};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.DropblocksVideoView", {hash:{
    'sourcesBinding': ("content.sources")
  },contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push("\n");
  hashTypes = {};
  hashContexts = {};
  data.buffer.push(escapeExpression(helpers.view.call(depth0, "Unlockable.DropblocksGameView", {hash:{},contexts:[depth0],types:["ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  return buffer;
  
});
Ember.TEMPLATES["DropblocksVideo"] = Ember.Handlebars.template(function anonymous(Handlebars,depth0,helpers,partials,data) {
this.compilerInfo = [3,'>= 1.0.0-rc.4'];
helpers = helpers || Ember.Handlebars.helpers; data = data || {};
  var buffer = '', stack1, hashTypes, hashContexts, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = '', hashContexts, hashTypes;
  data.buffer.push("\n<source ");
  hashContexts = {'src': depth0,'type': depth0};
  hashTypes = {'src': "STRING",'type': "STRING"};
  data.buffer.push(escapeExpression(helpers.bindAttr.call(depth0, {hash:{
    'src': ("source.src"),
    'type': ("source.type")
  },contexts:[],types:[],hashContexts:hashContexts,hashTypes:hashTypes,data:data})));
  data.buffer.push(">\n");
  return buffer;
  }

  hashTypes = {};
  hashContexts = {};
  stack1 = helpers.each.call(depth0, "source", "in", "view.sources", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),contexts:[depth0,depth0,depth0],types:["ID","ID","ID"],hashContexts:hashContexts,hashTypes:hashTypes,data:data});
  if(stack1 || stack1 === 0) { data.buffer.push(stack1); }
  data.buffer.push("\n");
  return buffer;
  
});
})