require({
    paths: {
        "text": "require/text",
        "cs": "require/cs",
        "ember": "lib/ember-1.0.pre",
        "handlebars" : "lib/handlebars-1.0.0.beta.6",
        "touch_punch": "lib/jquery.ui.touch-punch.min",
        "_": "lib/underscore-min",
        "modernizr":"lib/modernizr-latest",
        "jquery": "lib/jquery-1.7.2.min",
        "jqueryui": "lib/jquery-ui-1.9.1.custom.min",
        "crittercism": "lib/crittercismClientLibraryMin",
        "preload": 'lib/preloadjs-0.3.1.min',
        "sound": 'lib/soundjs-0.4.1.min',
        "settings": 'unlockable/settings-local',
    },
    shim:{
        ember: {
            exports: "Ember",
            deps: ['jquery', 'handlebars']
        },
		jquery: {
			exports: "$"
		},
        crittercism: {
            exports: "Crittercism",
        },
        handlebars: {
            exports: "Handlebars",
        },
        jqueryui: {
            deps: ['jquery']
        },
        touch_punch: {
            deps: ['jqueryui']
        },
        preload: {
            exports: 'createjs.PreloadJS',
        },
        sound: {
            exports: 'createjs.SoundJS',
        },
        _: {
            exports: "_",
        }
    },
        urlArgs: "bust=" +  (new Date()).getTime(),
},
        ['cs!unlockable/preloader'], function(preloader){
            require(["jquery", "ember", "_",
                     "modernizr",
                     'sound', "cs!unlockable/unlockable",
                     "cs!unlockable/main"], function($, Em,
                                                     _,  modernizr,
                                                     sound, Unlockable, Main){
                window.Unlockable = Unlockable;
                $(function(){
                    // Crittercism.init({
                    //     appId:       'Unlockable-dev',  // Example: 47cc67093475061e3d95369d
                    //     appVersion:  '1.0',    // Developer-provided application version
                    // });
                    window.setupUnlockable();
                    Unlockable.initialize();
                    Unlockable.router.transitionTo('boot');
                });
            });
        });
