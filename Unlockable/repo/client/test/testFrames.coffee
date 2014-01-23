require ['ember','chai', "cs!frames/models", "cs!frames/models_fixtures", "cs!trivia/controllers", "cs!trivia/views", "cs!trivia/trivia"], (Em, chai, models, fixtures, controllers, views, routes) ->
    {Frames, MixedupFramesMaster, Frame, FramePlayInfo, InplayFrame} = models
    {makeData} = fixtures
    testFrame1 = testFrame2 = testFrames1 = undefined
    oldSpiceFrame1 = oldSpiceFrame2 =oldSpiceFrame3 =oldSpiceFrame4 =oldSpiceFrame5 =oldSpiceFrame6  = undefined
    testFrames1  = undefined
    oldSpiceFrames = undefined

    getData = () ->
        {testFrame1, testFrame2, testFrames1
        oldSpiceFrames,
        oldSpiceFrame1, oldSpiceFrame2,oldSpiceFrame3,oldSpiceFrame4,oldSpiceFrame5,oldSpiceFrame6} = makeData()

    Em.testing = true
    expect = chai.expect
    beforeEach () ->
        getData()
        Em.run.begin()
    afterEach () ->
        Em.run.end()

    describe "Frames game data model", () ->
        it "should be able to add new frames",  () ->
            expect(testFrames1.get('frames')).to.have.length(1)
            testFrames1.addFrames(testFrame2)
            expect(testFrames1.get('frames')).to.have.length(2)
        it "should keep frames in sorted order", () ->
            frames = oldSpiceFrames.get('frames')
            prev = 0
            for frame in frames
                frame.get('order').should.be.above(prev)
                prev = frame.get('order')

        it "should keep track of the number of guesses made", () ->
            expect(oldSpiceFrames.attempts).to.exist

    describe "Frame data model", () ->
        it "should return the path to an image if one is set"
        it "should return a place holder image if one isn't set"

    describe "MixedupFramesMaster", () ->
        it "should shuffle frames"

    describe "FramePlayInfo", () ->
        it "should keep info on previous rounds"
        it "should keep info on current round"
        it "should keep state of which frames are available to choose from"

    describe "InplayFrame", () ->
        it "should be able to take a frame guess"
        it "should know if it's got a guess or not"
        it "should know when the guess is correct"
        it "should know when the guess know what picture it's showing"


    describe "FramesGuessController", () ->
        it "should be able to drop incorect guesses from the guess attempt", () ->

    describe "the Frames game flow ", () ->
        it "should start with the intro/instruction screen",
        it "should move from intro to commercial"
        it "should stay at the commercial specifc time"
        it "should move from commercial to gameplay"
        it "should move to a performance screen when the gameplay ends"
    describe "the Frames game state", () ->
        it "should start timer right after entering state"
        it "should should display FramesCheck screen on answer"
        it "should award points on FramesCheck screen for the number of frames in the right position, that weren't in the right position last time"
        it "should immedatly end the game when the clock runs out"
        it "should end the game after three guesses"
        it "should end the game after any guess if all the frames are in the right position"
    describe "the FramesCheck state", () ->
        it "should stop the timer as soon as it starts"
        it "should get correct ui elements on frames that are in the right spot"
        it "should get incorrect ui elements on an incorrect answer in questionResults screen"
        it "should allow you to move on"
    describe "the Triva Performace state", () ->
        it "should give a subtotal of all points earned in this game"
        it "should give a accuracry bounus if you answer all 6 questions right when the game ends"
        it "should give an 'a for effort' bonus if your score is less than 10% possible, that brings you up to 10%"
        it "should convert time remaining on the clock into points when done with triva"
        it "should give a total of all points earned in this game"
        it "should give player 1-3 starts depending on number of points /3"
        it "should check to see if they cross a threshhold to redeem and if so add in a 'redeem' button"
        it "should check to see if there is another game avaiable, and if so, add in a 'next game' button"
        it "should add a redeem button if no ads are availabe and the player has not crossed a threshhold"
