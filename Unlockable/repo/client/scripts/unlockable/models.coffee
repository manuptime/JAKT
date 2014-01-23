define ['ember'], (Em) ->
    User = Em.Object.extend
        points: 0
        addPoints: (points) ->
            oldPoints = @get('points')
            @set('points', oldPoints + points)
        id: null
        sittingId: null
        foreignId: null
        newUser: null
        takenSurvey: null
        hashedEmail: null
        offerId: null
        getProperties: () ->
            return {
                userId: @get('id')
                foreignId: @get('foreignId')
                sittingId: @get('sittingId')
                offerId: @get('offerId')
                hashedEmail: @get('hashedEmail')
            }


    MAX_TIME_IN_SECONDS = 30

    Game = Em.Object.extend
        ##ABS for all unlockable games
        timer: MAX_TIME_IN_SECONDS
        video: null
        logo: null
        maxPoints: 50000

        score: (() ->
            # The rule is Accuracy + time
            return @get('accuracyPoints') + @get('timePoints')
        ).property('accuracyPoints', 'timePoints')

        accuracyShare: () ->
            return .875 * (.8 * @get('maxPoints'))

        accuracyPoints: (() ->
            #(.875(.8*maxPoints) / Game actions)*Correct
            return Math.floor((@accuracyShare() / @get('gameActionsRating') * @get('correctChoices')) + @get('accuracyBonus'))
        ).property('gameActionsRating', 'correctChoices', 'accuracyBonus')

        accuracyBonus: (() ->
            #.125(.8*maxPoints) if earned, else 0
            if @get('earnedAccuracyBounus')
                return .125 * (.8*@get('maxPoints'))
            else
                return 0
        ).property('earnedAccuracyBounus')
        timePoints: (() ->
            #T = (t+Ba)(.2MGP / 30)
            if @get('accuracyPoints') < 15000
                return 0
            if @get('timer') + @get('timeBuffer') >= MAX_TIME_IN_SECONDS
                time = MAX_TIME_IN_SECONDS
            else
                time = @get('timer')
            return Math.floor(Math.min(time, MAX_TIME_IN_SECONDS) * @get('timeConstant'))
        ).property('accuracyPoints', 'timer', 'timeBuffer')

        timeConstant: (() ->
            timeConstant = (.2 * @get('maxPoints') / 30)
        ).property()

        possibleTimePoints: (() ->
            return MAX_TIME_IN_SECONDS * @get('timeConstant')
        ).property()

        gotMaxTimePoints: (() ->
            return @get('timePoints') >= @get('possibleTimePoints')
        ).property()

        # OVERRIDE THESE TO CONTROL POINTS
        correctChoices: (() ->
            #the multipler to account for the number of correct choices - higher means better
            return 1
        ).property()
        gameActionsRating: (() ->
            #the divisor to account for the number of actions taken by the player - less is better
            return 1
        ).property()
        earnedAccuracyBounus: (() ->
            #did the player earn the accuracy bonus?
            return false
        ).property()

        timeBuffer: 0


        stars: (() ->
            # 1 star: 0 - 25%
            # 2 stars: 26 - 75%
            # 3 stars: 76 - 100%
            points = @get('score')
            maxpoints = @get('maxPoints')
            percent = points / maxpoints
            if percent > .75
                return 3
            else if percent > .25
                return 2
            else
                return 1
        ).property()

        logoPath: (() ->
            logo = @get('logo')
            return "#{Unlockable.cdn}/#{logo}"
        ).property('logo')

        sources: (() ->
            formats = [{
                extension: "mp4"
                type: "video/mp4"
                },
                {
                extension: "webm"
                type: "video/webm"
                },
            ]
            video = @get('video')
            if video
                for format in formats
                    if video.indexOf(format.extension, video.length - format.extension.length) != -1
                        video = video.substr(0, video.length-(format.extension.length + 1)) #for the period
                        break

            return ({src: "#{Unlockable.cdn}/#{video}.#{format.extension}",type:format.type} for format in formats)
        ).property('video')

    return {
        User: User
        Game: Game
        MaxTimeInSeconds: MAX_TIME_IN_SECONDS
    }
