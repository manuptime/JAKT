define ['ember', "unlockable/templates"], (Em) ->
    return {
        ReadyToStartView: Em.View.extend
            templateName: 'readyToStart'

        GameView: Em.View.extend
            templateName: 'Game'

        WelcomeView : Em.View.extend
            elementId :  "Welcome"
            templateName: 'welcome'

        HowItWorksView : Em.View.extend
            templateName: 'howitworks'

        UnlockableView: Em.View.extend
            elementId: "Unlockable"
            templateName: "unlockable"

        GoodbyeView: Em.View.extend
            templateName: "Goodbye"

        SurveyView: Em.View.extend
            templateName: "Survey"

        ErrorView: Em.View.extend
            templateName: 'Error'

        OfferWindowView: Em.View.extend
            templateName: "offerWindow"

        MuteView: Em.View.extend
            tagName: "button"
            elementId: 'mute-btn'
            classNameBindings: ["Unlockable.isMuted:icon-volume-off:icon-volume-up"]
            click: ()->
                Unlockable.toggleMute()

        ScoreMercury: Em.View.extend
            tagName: 'div'
            classNames: ['scoreMercury']
            attributeBindings: ['style']
            calc_right: () ->
                points = Unlockable.get('router.currentPlayerController.points')
                needed = Unlockable.get('pointsNeeded')
                points = Math.min(points, needed)
                percent = (points / needed) * 100
                right_value = -(percent - 100)
                if right_value >= 0
                    return right_value
                else
                    right_value = 0
                    return right_value
            right_value: 100
            style: (() ->
                right_value = this.get('right_value')
                return "right:#{ right_value }%;"
                ).property('Unlockable.router.currentPlayerController.points', 'right_value')
            didInsertElement: () ->
                setTimeout( (=>
                    this.set('right_value', this.calc_right()))
                ,100) #delay the score just slightly so we can have a transition


        CommercialView: Em.View.extend
            tagName: 'video'
            templateName: "commercial"
            attributeBindings: ['width', 'height']
            elementId: "unlockable-commercial"
            #width: 320
            #height: 240
            ended: (event) ->
                Unlockable.router.send('commercialFinished')
            didInsertElement: () ->
                this.$().on('ended', $.proxy(this.ended, this))
                this.$()[0].play() #using autoplay causes some wierdniss.
        }
