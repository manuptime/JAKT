define ['cs!unlockable/unlockable'
        'sound'], (Unlockable) ->
    manifest = [
        {src:"#{ Unlockable.cdn }/sounds/bad_thing.ogg", id:1}
        {src:"#{ Unlockable.cdn }/sounds/good_thing.ogg", id:2}
        {src:"#{ Unlockable.cdn }/sounds/great_thing.ogg", id:3}
        {src:"#{ Unlockable.cdn }/sounds/unlockable_main_theme_full.ogg", id:4}
    ]

    createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashPlugin])
    createjs.Sound.registerManifest(manifest);


    music = null

    Unlockable.playSound = (id) ->
        #Play the sound: play (src, interrupt, delay, offset, loop, volume, pan)
        instance = createjs.Sound.play(id, createjs.Sound.INTERRUPT_NONE, 0, 1, false, 1)
    #always use strings for the sound id - soundjs, wat.
    Unlockable.playGoodSound = () ->
        Unlockable.playSound("2")
    Unlockable.playBadSound = () ->
        Unlockable.playSound("1")
    Unlockable.playGreatSound = () ->
        Unlockable.playSound("3")


    Unlockable.toggleMute = () ->
        isMuted = createjs.Sound.masterMute
        createjs.Sound.setMute(not isMuted)
        Unlockable.set('isMuted', not isMuted)

    Unlockable.isMuted =  false

    Unlockable.stopMusic = ->
        if music != null
            music.pause()

    Unlockable.startMusic = ->
        if music == null
            music = createjs.Sound.play("4")
        else
            music.play()
