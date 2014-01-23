require({
    paths: {
        "text": "require/text",
        "cs": "require/cs",
        "ember": "lib/ember-1.0.pre",
        "handlebars" : "lib/handlebars-1.0.0.beta.6",
        "touch_punch": "lib/jquery.ui.touch-punch.min",
        "_": "lib/underscore-min",
        "modernizr":"lib/modernizr-latest",
        "jquery": "require/require-jquery",
        "jqueryui": "lib/jquery-ui-1.9.1.custom.min",
        "crittercism": "lib/crittercismClientLibraryMin",
        "preload": 'lib/preloadjs-0.2.0.min',
        "sound": 'lib/soundjs-NEXT.min',
        "settings": 'unlockable/settings-qa',
        "mocha": "../test/mocha",
        "chai": "../test/chai",
    },
    baseUrl: "/scripts/",
    shim:{
        ember: {
            exports: "Ember",
            deps: ['jquery', 'handlebars']
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
            exports: "createjs"
        },
        sound: {
            exports: "createjs"
        },
        _: {
            exports: "_",
        }
    },
    urlArgs: "bust=" +  (new Date()).getTime(),
    },
        ["jquery", "ember", "cs!unlockable/unlockable", "mocha", "chai"], function($, Em, Unlockable, Mocha, chai){
            mocha.setup({ui:'bdd',
                         globals: [ 'Unlockable', "_" ]
                        })
            var should = chai.should()
            require(["cs!../test/testFrames", "cs!../test/testTrivia", 'cs!../test/testMain', 'cs!../test/testUnlockable'],
                    function(testFrames, testTrivia, testMain, testUnlockable){
                        Em.run.begin()
               mocha.run()
            });
        });
