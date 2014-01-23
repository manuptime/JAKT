require ['ember','chai', "cs!trivia/models", "cs!trivia/models_fixtures", "cs!trivia/controllers", "cs!trivia/views", "cs!trivia/trivia"], (Em, chai, models, fixtures, controllers, views, routes) ->
    {Answer, Question, AnswerAttempt} = models
    {makeData} = fixtures
    testAnswer1 =  testAnswer2 =  testAnswer3 =  testAnswer4 = undefined
    testQuestion1 =  testQuestion2 = testQuestion3 = undefined
    triviaController = undefined
    testTrivia = undefined
    getData = () ->
        {testAnswer1, testAnswer2, testAnswer3, testAnswer4
         testQuestion1, testQuestion2, testQuestion3
         testTrivia} = makeData()

    Em.testing = true
    expect = chai.expect    
    beforeEach () ->
        getData()
        Em.run.begin()
    afterEach () ->  
        Em.run.end()

    describe "Trivia Games", () ->
        beforeEach () ->
            getData()
            Em.run.begin()
        it "should be able to take new questions", ->
            testTrivia.get('questions').should.be.length(1)
            testTrivia.addQuestions(testQuestion2)
            testTrivia.get('questions').should.be.length(2)
        it "questions added to a trivia should get a game property ", ->
            expect(testQuestion2.game).to.be.null
            testTrivia.addQuestions(testQuestion2)
            expect(testQuestion2.game).to.exist
            testQuestion2.game.should.be.equal(testTrivia)

        it "should be able to remove questions", ->
            testTrivia.get('questions').should.be.length(1)
            testTrivia.removeQuestion(testQuestion1)
            testTrivia.get('questions').should.be.length(0)

    describe "Trivia Questions", () ->
        beforeEach () ->
            getData()
            Em.run.begin()
        it "should be able to take new answers", () ->
            testQuestion1.get('answers').should.be.length(4)
            newAnswer = Answer.create(answer: "doop")
            newAnswer2 = Answer.create(answer: "ploot")
            testQuestion1.addAnswers(newAnswer, newAnswer2)
            testQuestion1.get('answers').should.be.length(6)
        it "should be able to remove answers", () ->
            testQuestion1.get('answers').should.be.length(4)
            result = testQuestion1.removeAnswer('asdf')
            result.should.be.false
            result = testQuestion1.removeAnswer(testAnswer1)
            testQuestion1.get('answers').should.be.length(3)
            result = testQuestion1.removeAnswer()
        it "should assume that the first answer given is correct, unless there's already a correct answer set", () ->
            testQuestion1.get('correctAnswer').should.equal(testAnswer2)
            testQuestion1.set('questions', [])
            testQuestion1.addAnswers(
                testAnswer1
                testAnswer2
                testAnswer3
                testAnswer4
            )
            testQuestion1.get('correctAnswer').should.equal(testAnswer2)
            testQuestion1.set('questions', [])
            testQuestion1.set('correctAnswer', null)
            testQuestion1.addAnswers(
                testAnswer1
                testAnswer2
                testAnswer3
                testAnswer4
            )

            testQuestion1.get('correctAnswer').should.equal(testAnswer1)

        it "should have a question that the player can read", () ->
            testQuestion1.set('questionText', "What is the airspeed of an unladen swallow")
            testQuestion1.toString().should.be.equal("What is the airspeed of an unladen swallow")
        it "should be independent from other trivia questions", () ->
            testQuestion1.get('answers').should.be.length(4)
            testQuestion2.get('answers').should.be.length(0)
            testQuestion2.addAnswers(testAnswer1)
            testQuestion1.get('answers').should.be.length(4)
            testQuestion2.get('answers').should.be.length(1)

    describe "Triva Answers", () ->
        beforeEach () ->
            getData()
        it "should have an answer that a player can read", () ->
            testAnswer2.toString().should.be.equal("T-Rex")
        it "should know if it's the correct answer or not", () ->
            testAnswer2.get('isCorrect').should.be.true
            testAnswer1.get('isCorrect').should.be.false
        it "and the correct answer should change if the question changes", ->
            testAnswer2.get('isCorrect').should.be.true
            testAnswer1.get('isCorrect').should.be.false
            testQuestion1.set('correctAnswer', testAnswer1)
            testAnswer1.get('isCorrect').should.be.true
            testAnswer2.get('isCorrect').should.be.false

    # describe "The Triva Controller", ()->
    #     beforeEach () ->
    #         getData()
    #         Em.run.begin()
    #         triviaController = controllers.TriviaController.create
    #             content: testTrivia

        # it "should be able to keep a timer", () ->
        #     triviaController.get('timer').should.exist
        #     #triviaController.get('timer').should.be.equal()

        # it "should be able to start the timer",  (done) ->
        #     oldval = triviaController.get('timer')
        #     triviaController.startTimer()
        #     done()
        # it "should be able to end the timer if it's running", (done) ->
        #     oldval = triviaController.get('timer')
        #     triviaController.startTimer()
        #     Em.run.next(() -> # anon function, run on next run loop iter
        #         triviaController.endTimer()
        #         newVal = triviaController.get('timer')
        #         newVal.should.be.below(oldval)
        #         done()
        #         )

        # it "should be able to start the timer, end the timer, and start again", (done) ->
        #     oldval = triviaController.get('timer')
        #     triviaController.startTimer()
        #     Em.run.next ()->
        #         triviaController.endTimer()
        #         firstVal = triviaController.get('timer')
        #         firstVal.should.be.below(oldval)
        #         Em.run.next () ->
        #             triviaController.startTimer()
        #             Em.run.next () ->
        #                 triviaController.endTimer()
        #                 secondVal = triviaController.get('timer')
        #                 secondVal.should.be.below(firstVal)
        #                 done()

    describe "The Triva Points System", () ->
        beforeEach () ->
            #getData()
            Em.run.begin()

        # NaN
        it "score", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('score')).to.equal(0)

        # 37500
        it "accuracyShare", () ->
            trivia = models.Trivia.create()
            expect(trivia.accuracyShare()).to.equal(0)

        # NaN
        it "accuracyPoints", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('accuracyPoints')).to.equal(0)

        # 2500
        it "accuracyBonus", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('accuracyBonus')).to.equal(0)

        # 10000
        it "timePoints", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('timePoints')).to.equal(0)

        # 333.33
        it "timeConstant", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('timeConstant')).to.equal(0)

        # 10000
        it "possibleTimePoints", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('possibleTimePoints')).to.equal(0)

        # undefined
        it "stars", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('starts')).to.equal(0)

        # 0
        it "answersRight", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('answersRight')).to.equal(0)

        # 0 
        it "gameActionsRating", () ->
            trivia = models.Trivia.create()
            trivia.addQuestions(testQuestion2)
            trivia.addQuestions(testQuestion2)
            trivia.addQuestions(testQuestion2)
            trivia.addQuestions(testQuestion2)
            expect(trivia.get('gameActionsRating')).to.equal(0)

        # undef
        it "earnedAccuracyBonus", () ->
            trivia = models.Trivia.create()
            expect(trivia.get('earnedAccuracyBonus')).to.equal(0)

        it "None correct, ran out of time", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer1 }) 
            trivia.addAttempts(attempt)
            #debugger

            trivia.set('timer', 0)
            trivia.dump("None correct, ran out of time")

            expect(trivia.get('accuracyPoints')).to.equal(0)              
            expect(trivia.get('timePoints')).to.equal(0)


        it "None correct, some time left", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer1 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 10)
            trivia.dump("None correct, some time left")                        

            expect(trivia.get('accuracyPoints')).to.equal(0)              
            expect(trivia.get('timePoints')).to.be.above(0)


        it "None correct, perfect buffer time", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer1 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 30)

            trivia.dump("None correct, perfect buffer time")                        

            expect(trivia.get('accuracyPoints')).to.equal(0)                   
            expect(trivia.get('timePoints')).to.equal(10000)

            
        it "Some correct, ran out of time", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 0)
            trivia.dump("Some correct, ran out of time")
            
            expect(trivia.get('accuracyPoints')).to.be.below(40000)                   
            expect(trivia.get('timePoints')).to.equal(0)
            
        it "Some correct, some time left", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 15)
            trivia.dump("Some correct, some time left")
            
            expect(trivia.get('accuracyPoints')).to.be.below(40000)                   
            expect(trivia.get('timePoints')).to.be.above(0)

        it "Some correct, perfect buffer time", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 30)
            trivia.dump("Some correct, perfect buffer time")

            expect(trivia.get('accuracyPoints')).to.be.below(40000)       
            expect(trivia.get('timePoints')).to.equal(10000)

        it "All correct, ran out of time", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 0)
            trivia.dump("All correct, ran out of time")
            
            expect(trivia.get('accuracyPoints')).to.equal(40000)                   
            expect(trivia.get('timePoints')).to.equal(0)
            
        it "All correct, some time left", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 15)
            trivia.dump("All correct, some time left")
            
            expect(trivia.get('accuracyPoints')).to.equal(40000)                   
            expect(trivia.get('timePoints')).to.be.above(0)

        it "All correct, perfect buffer time", () ->
            trivia = models.Trivia.create()
            
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)
            trivia.addQuestions(testQuestion1)

            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)
            attempt = AnswerAttempt.create({ answer: testAnswer2 }) 
            trivia.addAttempts(attempt)

            trivia.set('timer', 30)
            trivia.dump("All correct, perfect buffer time")

            expect(trivia.get('accuracyPoints')).to.equal(40000)       
            expect(trivia.get('timePoints')).to.equal(10000)


    describe "the Trivia game flow ", () ->
        it "should start with the intro/instruction screen", () ->
        it "should move from intro to commercial"
        it "should stay at the commercial specifc time"
        it "should move from commercial to gameplay"
        it "should move to a performance screen when the gameplay ends"
        it "should give questions in specific order"
        it "should should move to the performace screen after all questions"
    describe "the Triva game state", () ->
        it "should start timer right after entering state"
        it "should should display questionResult screen on answer"
        it "should get incorrect sound on incorrect answer"
        it "should get correct sound on correct answer"
        it "should award points at on a correct answer"
        it "should not award points on a incorrect answer"
        it "should immedatly end the game when the clock runs out"
        it "should end the game when all the questions have been asked"
    describe "the answer review state", () ->
        it "should stop the timer as soon as it starts"
        it "should show the answer choices from the last question"
        it "should mark the chosen answer"
        it "should mark the correct answer"
        it "should get correct ui elements on an correct answer in questionResults screen"
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

