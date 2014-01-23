define ["settings", 'preload', 'sound'], (settings) ->
    preloader = new createjs.LoadQueue(true)
    preloader.installPlugin(createjs.Sound)

    preloader.setMaxConnections(4)
    preloader.loadFile("#{ settings.cdn }/css/screen.css")
    preloader.loadFile("#{ settings.cdn }/media/img/bigX.png")

    preloader.onFileLoad = (event)->
        switch event.type
            when createjs.PreloadJS.CSS
                (document.head or document.getElementsByTagName("head")[0]).appendChild(event.result)
            when createjs.PreloadJS.SOUND
                document.body.appendChild(result)
    return preloader