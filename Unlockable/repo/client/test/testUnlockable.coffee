require ['ember', 'chai', "cs!unlockable/unlockable", "cs!unlockable/models"], (Em, chai, Unlockable, models) ->

    expect = chai.expect
    
    describe "Unlockable inital state", () ->
        it "should deactivate the application when there's no ad inventory"
        it "should fire an ajax request to determine ad availabity on enter"
        it "should transition to a ready state when there's ad inventory"
        it "should trasition into the welcome state when activated by the user"

    describe "Unlockable game flow", () ->
        it "should start player with 0 points"
        it "should allow players to redeem points for tokens at hardcoded thresholds"
        it "should redeems players outstanding points, rounded down, for tokens when we run out of ad inventory"
    #make sure that routes are setup property, with controller and target set correctly

    
    describe "Point System", () ->
        beforeEach () ->
            #getData()
            Em.run.begin()

        game = models.Game.create()
        MAX_POINTS = game.maxPoints
        MAX_TIME = game.timer
            
        it "Max Timer is 30s", () ->
            game = models.Game.create()
            expect(game.get('timer')).to.equal(MAX_TIME)

        it "Max Points 50000", () ->
            game = models.Game.create()
            expect(game.get('maxPoints')).to.equal(MAX_POINTS)

        it "Accuracy Share", () ->
            game = models.Game.create()
            expect(game.accuracyShare()).to.equal(0.9375 * 0.8 * MAX_POINTS)

        it "Time Constant", () ->
            game = models.Game.create()
            expect((game.get('maxPoints')* 0.2)/30).to.equal((MAX_POINTS * 0.2)/30)

        it "accuracyShare", () ->
            game = models.Game.create()
            expect(game.accuracyShare()).to.equal(0.9375 * (0.8 * MAX_POINTS))
            


