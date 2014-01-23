({
    //appDir: ".",
    baseUrl: ".",
    //dir: "../webapp-build",
    out: "../webapp-build/unlockable.js",
    //Comment out the optimize line if you want
    //the code minified by UglifyJS.
    optimize: "none",
	normalizeDirDefines: "all",
    waitSeconds: 200,


    //Stub out the cs module after a build since
    //it will not be needed.
    exclude: ['coffee-script'],
    stubModules: ['cs', 'text'],
    findNestedDependencies: true,
    mainConfigFile: 'main.js',
    include: ['main'],
    insertRequire: ['main'],
	name: "almond",
    paths: {
         "settings": 'unlockable/settings-demo',
    },

    // modules: [
    //     {
    //         name: "main",
    //         exclude: ['coffee-script']

    //     }
    // ]
})
