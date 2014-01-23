define ['jquery'
        'ember'
        'settings'
        'cs!unlockable/preloader'
        'cs!unlockable/models'
        'cs!unlockable/views'
        'cs!unlockable/controllers'], ($, Em, settings, preloader, Models, Views, Controllers) ->



    if typeof String.prototype.startsWith != 'function'
          String.prototype.startsWith = (str) ->
             return this.indexOf(str) == 0;

    Em.Object.reopenClass
        toJson :() ->
            ret = this.getProperties.apply(this, Object.keys(this))
            return (key for key in ret if not key.startsWith("__"))

    Em.Route.reopen
        enter: (router) ->
            @_super(router)
            if not @get('isLeaf') or @get('noRecord')
                return
            from = router.get('currentState')?.get('path')
            Em.run.next this, () ->
                # defer this because the very first enter is called before the app finishes loading
                # by deferring it we ensure that the load has completed
                eventdata = {}
                eventdata['from'] = from
                eventdata['to'] = this.get('path')
                Unlockable.createAnalyticEvent("state_transition", eventdata)

    #Em.onerror = (e) ->
        #Crittercism.logHandledException(e)
        #debugger
        #console.log(e)
        #Unlockable.router.transitionTo('error')

    Unlockable = Em.Application.create

        rootElement: $("#unlockable-main")
        toString: ()->
            return "Unlockable"

        ApplicationController: Em.ObjectController.extend({})

        ApplicationView: Em.View.extend
            templateName: 'base'

        introText: "40 Free Tokens"
        exitText: "40 Free Tokens"
        exitTextDomain: "(back at FreeAwesome.com)"

        pointsNeeded: 200000
        #pointsNeeded: 100000
        #pointsNeeded: 25000
        useFixtures: settings.useFixtures
        debug: settings.debug # for deubgging
        survey: false

        likeAd: (game) ->
            eventdata = {}
            eventdata['game_id'] = game.id
            Unlockable.createAnalyticEvent("like", eventdata)
            #Unlockable.router.transitionTo('error')

        host: settings.host
        cdn: settings.cdn

        capitalise: (string) ->
            return string.charAt(0).toUpperCase() + string.slice(1);

        Games: {} #Store the names for the games here

        preloader: preloader

        inventoryCallback: (hasInventory) ->
            window.unlockableInventory(hasInventory)

        startUnlockable: () ->
            Unlockable.router.transitionTo('unlockable')

        setupLocalData: () ->
            currentUser = Models.User.create
                foreignId: window.UnlockableData['foreignId']
                hashedEmail: window.UnlockableData['hashedEmail']
                takenSurvey: true

            Unlockable.router.currentPlayerController.set('content', currentUser)
            Unlockable.api_key = window.UnlockableData['api_key']


        createAnalyticEvent: (name, details) ->
            analytics = Unlockable.router.get('currentPlayerController.content').getProperties()
            analytics['timestamp'] = (new Date()).toUTCString()
            analytics['eventtype'] = name

            analytics['eventdata'] = details
            $.ajax
                type: "POST",
                url: "#{ Unlockable.host }/beta/analytics/"
                data: JSON.stringify(analytics)
                #contentType: "application/json; charset=utf-8"
                dataType: "json"
                success: (data) ->
                    2
                failure: (errMsg) ->
                    2


        finishGame: (game) ->
            #payload needs to include:
            # time game started
            # points
            # game id
            # sitting id
            #
            payload = Unlockable.router.currentPlayerController.get('content').getProperties()

            payload['timestart'] = game.timestarted
            payload['timer'] = game.timer
            payload['actions']  = game.get('correctChoices')
            payload['points'] = game.get('score')
            payload['gameId'] = game.id
            $.ajax
                type: "POST",
                url: "#{ Unlockable.host }/beta/gamefinished/"
                data: JSON.stringify(payload)
                #contentType: "application/json; charset=utf-8"
                dataType: "json"


        startGame: (game) ->
            #payload needs to include:
            # time game started
            # sitting id
            #console.log "startGame"
            payload = Unlockable.router.currentPlayerController.get('content').getProperties()
            payload['gameId'] = game.id
            payload['timestart'] = game.timestarted
            $.ajax
                type: "POST",
                url: "#{ Unlockable.host }/beta/gamestart/"
                data: JSON.stringify(payload)
                #contentType: "application/json; charset=utf-8"
                dataType: "json"



        getMoreGames: () ->
            payload = Unlockable.router.currentPlayerController.get('content').getProperties()
            $.ajax
                type: "POST",
                url: "#{ Unlockable.host }/beta/moregames/"
                data: JSON.stringify(payload)
                #contentType: "application/json; charset=utf-8"
                dataType: "json"
                success: (data) ->
                    response = JSON.parse(data.data)
                    games = response.games
                    Unlockable.parseGames(games)

        recordModelOpen: () ->
            payload = Unlockable.router.currentPlayerController.get('content').getProperties()
            $.ajax
                type: "POST",
                url: "#{ Unlockable.host }/beta/modelopen/"
                data: JSON.stringify(payload)
                dataType: "json"



        getInitialData: () ->
            payload = Unlockable.router.currentPlayerController.get('content').getProperties()
            $.ajax
                type: "POST",
                url: "#{ Unlockable.host }/beta/initial/"
                data: JSON.stringify(payload)
                #contentType: "application/json; charset=utf-8"
                dataType: "json"
                success: (data) ->
                    response = JSON.parse(data.data)
                    games = response.games

                    currentPlayer = Unlockable.router.currentPlayerController.get('content')
                    currentPlayer.set('id', response.user.id)
                    currentPlayer.set('sittingId', response.user.sitting)
                    currentPlayer.set('newUser', response.user.new_user)
                    currentPlayer.set('offerId', response.offer_id)
                    currentPlayer.set('takenSurvey', response.user.taken_survey)
                    if $.isEmptyObject(games) or _.every(_.values(games), _.isNull)
                        Unlockable.router.send('noInventory')
                        return
                    Unlockable.parseGames(games)
                    Unlockable.router.send('weHaveInventory')

    for key of Controllers
        Unlockable[key] = Controllers[key]
    for key of Views
        Unlockable[key] = Views[key]

    if Unlockable.debug
        Em.LOG_STATE_TRANSITIONS = true
        Em.ENV.RAISE_ON_DEPRECATION = true
        Unlockable.LOG_TRANSITIONS = true
        Unlockable.LOG_VIEW_LOOKUPS = true
        Unlockable.LOG_TRANSITIONS_INTERNAL = true
        Unlockable.LOG_BINDINGS = true
        Unlockable.LOG_ACTIVE_GENERATION = true
        Unlockable.LOG_VERSION = true



    return Unlockable
