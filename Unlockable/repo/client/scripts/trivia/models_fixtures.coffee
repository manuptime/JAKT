define ['cs!trivia/models'], (TriviaModels) ->
    {Question, Answer, Trivia} = TriviaModels
    makeData = () ->
        testAnswer1 = Answer.create
            answer: "Jerkasaurus"

        testAnswer2 =  Answer.create
            answer: "T-Rex"

        testAnswer3 = Answer.create
            answer: "Brontosaurus"

        testAnswer4 = Answer.create
            answer: "That spitter thing"

        testQuestion1 = Question.create()
        testQuestion1.set('questionText', "What isn't the best dinosaur?")
        testQuestion1.addAnswers(
                    testAnswer1
                    testAnswer2
                    testAnswer3
                    testAnswer4
        )
        testQuestion1.set('correctAnswer', testAnswer2)

        testTrivia = Trivia.create(
            logo: "media/img/fixtures/brand_logos/logo_Allstate.jpg"
        )

        testTrivia.addQuestions(testQuestion1)

            ## ---------------------------------------------------------    Allstate "Mayhem GPS"
        allStateTrivia = Trivia.create
            video: "media/video/allstate_gps"
            logo: "media/img/fixtures/brand_logos/logo_Allstate.jpg"

        allStateQuestionOne = Question.create
            questionText: "What's causing mayhem?"
        allStateQuestionOneAnswerOne = Answer.create
            answer: "GPS"
        allStateQuestionOneAnswerTwo = Answer.create
            answer: "Steering Wheel"
        allStateQuestionOneAnswerThree = Answer.create
            answer: "Hot Coffee"
        allStateQuestionOneAnswerFour = Answer.create
            answer: "Windshield Wipers"

        allStateQuestionOne.addAnswers(
            allStateQuestionOneAnswerOne
            allStateQuestionOneAnswerTwo
            allStateQuestionOneAnswerThree
            allStateQuestionOneAnswerFour
        )

        allStateQuestionOne.set('correctAnswer', allStateQuestionOneAnswerOne)

        allStateQuestionTwo = Question.create
            questionText: "What may not pay for repairs?"
        allStateQuestionTwoAnswerOne = Answer.create
            answer: "15-Minute Insurance"
        allStateQuestionTwoAnswerTwo = Answer.create
            answer: "Cut-Rate Insurance"
        allStateQuestionTwoAnswerThree = Answer.create
            answer: "No-Credit Insurance"
        allStateQuestionTwoAnswerFour = Answer.create
            answer: "High-Mileage Insurance"

        allStateQuestionTwo.addAnswers(
            allStateQuestionTwoAnswerOne
            allStateQuestionTwoAnswerTwo
            allStateQuestionTwoAnswerThree
            allStateQuestionTwoAnswerFour
        )

        allStateQuestionTwo.set('correctAnswer', allStateQuestionTwoAnswerOne)

        allStateQuestionThree = Question.create
            questionText: "What color is the driver's car?"
        allStateQuestionThreeAnswerOne = Answer.create
            answer: "Green"
        allStateQuestionThreeAnswerTwo = Answer.create
            answer: "Blue"
        allStateQuestionThreeAnswerThree = Answer.create
            answer: "Red"
        allStateQuestionThreeAnswerFour = Answer.create
            answer: "White"

        allStateQuestionThree.addAnswers(
            allStateQuestionThreeAnswerOne
            allStateQuestionThreeAnswerTwo
            allStateQuestionThreeAnswerThree
            allStateQuestionThreeAnswerFour
        )

        allStateQuestionThree.set('correctAnswer', allStateQuestionThreeAnswerOne)


        allStateQuestionFour = Question.create
            questionText: "Why does the GPS have to wing it?"
        allStateQuestionFourAnswerOne = Answer.create
            answer: "It's never updated"
        allStateQuestionFourAnswerTwo = Answer.create
            answer: "Can't connect to satellites"
        allStateQuestionFourAnswerThree = Answer.create
            answer: "It's an older model"
        allStateQuestionFourAnswerFour = Answer.create
            answer: "It's out of batteries"


        allStateQuestionFour.addAnswers(
            allStateQuestionFourAnswerOne
            allStateQuestionFourAnswerTwo
            allStateQuestionFourAnswerThree
            allStateQuestionFourAnswerFour
        )


        allStateQuestionFour.set('correctAnswer', allStateQuestionFourAnswerOne)


        allStateQuestionFive = Question.create
            questionText: "What brand protects you from Mayhem?"
        allStateQuestionFiveAnswerOne = Answer.create
            answer: "Allstate"
        allStateQuestionFiveAnswerTwo = Answer.create
            answer: "Ford"
        allStateQuestionFiveAnswerThree = Answer.create
            answer: "State Farm"
        allStateQuestionFiveAnswerFour = Answer.create
            answer: "Volkswagen"

        allStateQuestionFive.addAnswers(
            allStateQuestionFiveAnswerOne
            allStateQuestionFiveAnswerTwo
            allStateQuestionFiveAnswerThree
            allStateQuestionFiveAnswerFour
        )


        allStateQuestionFive.set('correctAnswer', allStateQuestionFiveAnswerOne)

        allStateQuestionSix = Question.create
            questionText: "What product is being advertised?"
        allStateQuestionSixAnswerOne = Answer.create
            answer: "Insurance"
        allStateQuestionSixAnswerTwo = Answer.create
            answer: "GPS"
        allStateQuestionSixAnswerThree = Answer.create
            answer: "Car"
        allStateQuestionSixAnswerFour = Answer.create
            answer: "Extended Warranty"

        allStateQuestionSix.addAnswers(
            allStateQuestionSixAnswerOne
            allStateQuestionSixAnswerTwo
            allStateQuestionSixAnswerThree
            allStateQuestionSixAnswerFour
        )

        allStateQuestionSix.set('correctAnswer', allStateQuestionSixAnswerOne)
        allStateTrivia.addQuestions(
            allStateQuestionOne
            allStateQuestionTwo
            allStateQuestionThree
            allStateQuestionFour
            allStateQuestionFive
            allStateQuestionSix
        )

        # ---------------------------------------------------------------------- PBS Silicon Valley
        #
        #
        amexTrivia = Trivia.create
            video: "media/video/AMERICAN_EXPERIENCE_Silicon_Valley_promo"
            logo: "media/img/fixtures/brand_logos/logo_PBS.png"


        amexQuestionOne = Question.create
            questionText: "What begins on a very specific morning?"
        amexQuestionOneAnswerOne = Answer.create
            answer: "Silcon Valley"
        amexQuestionOneAnswerTwo = Answer.create
            answer: "Apple"
        amexQuestionOneAnswerThree = Answer.create
            answer: "The Revolution"
        amexQuestionOneAnswerFour = Answer.create
            answer: "The Future"

        amexQuestionOne.addAnswers(
            amexQuestionOneAnswerOne
            amexQuestionOneAnswerTwo
            amexQuestionOneAnswerThree
            amexQuestionOneAnswerFour
        )

        amexQuestionOne.set('correctAnswer', amexQuestionOneAnswerOne)

        amexQuestionTwo = Question.create
            questionText: "What was “the little thing he helped invent?”"
        amexQuestionTwoAnswerOne = Answer.create
            answer: "Microchip"
        amexQuestionTwoAnswerTwo = Answer.create
            answer: "iPad"
        amexQuestionTwoAnswerThree = Answer.create
            answer: "Transistor"
        amexQuestionTwoAnswerFour = Answer.create
            answer: "Keyboard"

        amexQuestionTwo.addAnswers(
            amexQuestionTwoAnswerOne
            amexQuestionTwoAnswerTwo
            amexQuestionTwoAnswerThree
            amexQuestionTwoAnswerFour
        )

        amexQuestionTwo.set('correctAnswer', amexQuestionTwoAnswerOne)



        amexQuestionThree = Question.create
            questionText: "What is the name of the show?"
        amexQuestionThreeAnswerOne = Answer.create
            answer: "American Experience"
        amexQuestionThreeAnswerTwo = Answer.create
            answer: "The Story of Silicon Valley"
        amexQuestionThreeAnswerThree = Answer.create
            answer: "The Day the World Changed"
        amexQuestionThreeAnswerFour = Answer.create
            answer: "Computer Tales"

        amexQuestionThree.addAnswers(
            amexQuestionThreeAnswerOne
            amexQuestionThreeAnswerTwo
            amexQuestionThreeAnswerThree
            amexQuestionThreeAnswerFour
        )
        amexQuestionThree.set('correctAnswer', amexQuestionThreeAnswerOne)

        # amexQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # amexQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # amexQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # amexQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # amexQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # amexQuestionFour.addAnswers(
        #     amexQuestionFourAnswerOne
        #     amexQuestionFourAnswerTwo
        #     amexQuestionFourAnswerThree
        #     amexQuestionFourAnswerFour
        # )


        # amexQuestionFour.set('correctAnswer', amexQuestionFourAnswerOne)

        amexQuestionFive = Question.create
            questionText: "'The story of how <span class='underscore'>______</span>began.'"
        amexQuestionFiveAnswerOne = Answer.create
            answer: "The Information Age"
        amexQuestionFiveAnswerTwo = Answer.create
            answer: "Mobile Technology"
        amexQuestionFiveAnswerThree = Answer.create
            answer: "The 21st Century"
        amexQuestionFiveAnswerFour = Answer.create
            answer: "The Modern Era"

        amexQuestionFive.addAnswers(
            amexQuestionFiveAnswerOne
            amexQuestionFiveAnswerTwo
            amexQuestionFiveAnswerThree
            amexQuestionFiveAnswerFour
        )


        amexQuestionFive.set('correctAnswer', amexQuestionFiveAnswerOne)


        amexQuestionSix = Question.create
            questionText: "Which was NOT in the video?"
        amexQuestionSixAnswerOne = Answer.create
            answer: "Steve Jobs"
        amexQuestionSixAnswerTwo = Answer.create
            answer: "Black and White Photos"
        amexQuestionSixAnswerThree = Answer.create
            answer: "Astronaut"
        amexQuestionSixAnswerFour = Answer.create
            answer: "Chip Manufacturing"

        amexQuestionSix.addAnswers(
            amexQuestionSixAnswerOne
            amexQuestionSixAnswerTwo
            amexQuestionSixAnswerThree
            amexQuestionSixAnswerFour
        )

        amexQuestionSix.set('correctAnswer', amexQuestionSixAnswerOne)
        amexTrivia.addQuestions(
            amexQuestionOne
            amexQuestionTwo
            amexQuestionThree
            #amexQuestionFour
            amexQuestionFive
            amexQuestionSix
        )

        # ---------------------------------------------------------------------- Oreo "Whisper"
        #
        #

        oreoTrivia = Trivia.create
            video: "media/video/OREO_Whisper_Fight"
            logo: "media/img/fixtures/brand_logos/logo_oreo.png"

        oreoQuestionOne = Question.create
            questionText: "Which cookie caused the chaos?"
        oreoQuestionOneAnswerOne = Answer.create
            answer: "Oreo"
        oreoQuestionOneAnswerTwo = Answer.create
            answer: "Chips Ahoy"
        oreoQuestionOneAnswerThree = Answer.create
            answer: "Ginger Snaps"
        oreoQuestionOneAnswerFour = Answer.create
            answer: "Fig Newtons"

        oreoQuestionOne.addAnswers(
            oreoQuestionOneAnswerOne
            oreoQuestionOneAnswerTwo
            oreoQuestionOneAnswerThree
            oreoQuestionOneAnswerFour
        )

        oreoQuestionOne.set('correctAnswer', oreoQuestionOneAnswerOne)

        oreoQuestionTwo = Question.create
            questionText: "Who drove through a brick wall?"
        oreoQuestionTwoAnswerOne = Answer.create
            answer: "Cops"
        oreoQuestionTwoAnswerTwo = Answer.create
            answer: "Firefighters"
        oreoQuestionTwoAnswerThree = Answer.create
            answer: "Librarians"
        oreoQuestionTwoAnswerFour = Answer.create
            answer: "Students"

        oreoQuestionTwo.addAnswers(
            oreoQuestionTwoAnswerOne
            oreoQuestionTwoAnswerTwo
            oreoQuestionTwoAnswerThree
            oreoQuestionTwoAnswerFour
        )

        oreoQuestionTwo.set('correctAnswer', oreoQuestionTwoAnswerOne)



        oreoQuestionThree = Question.create
            questionText: "What couldn’t the Oreo lovers agree on?"
        oreoQuestionThreeAnswerOne = Answer.create
            answer: "The Best Part"
        oreoQuestionThreeAnswerTwo = Answer.create
            answer: "How to Eat Them"
        oreoQuestionThreeAnswerThree = Answer.create
            answer: "To Dunk or Not To Dunk"
        oreoQuestionThreeAnswerFour = Answer.create
            answer: "Their Favorite Flavor"

        oreoQuestionThree.addAnswers(
            oreoQuestionThreeAnswerOne
            oreoQuestionThreeAnswerTwo
            oreoQuestionThreeAnswerThree
            oreoQuestionThreeAnswerFour
        )
        oreoQuestionThree.set('correctAnswer', oreoQuestionThreeAnswerOne)

        # oreoQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # oreoQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # oreoQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # oreoQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # oreoQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # oreoQuestionFour.addAnswers(
        #     oreoQuestionFourAnswerOne
        #     oreoQuestionFourAnswerTwo
        #     oreoQuestionFourAnswerThree
        #     oreoQuestionFourAnswerFour
        # )


        # oreoQuestionFour.set('correctAnswer', oreoQuestionFourAnswerOne)

        oreoQuestionFive = Question.create
            questionText: "Which came first?"
        oreoQuestionFiveAnswerOne = Answer.create
            answer: "Overturned Table"
        oreoQuestionFiveAnswerTwo = Answer.create
            answer: "Smashed Lamp"
        oreoQuestionFiveAnswerThree = Answer.create
            answer: "Downed Bookshelves"
        oreoQuestionFiveAnswerFour = Answer.create
            answer: "Broken Railing"

        oreoQuestionFive.addAnswers(
            oreoQuestionFiveAnswerOne
            oreoQuestionFiveAnswerTwo
            oreoQuestionFiveAnswerThree
            oreoQuestionFiveAnswerFour
        )


        oreoQuestionFive.set('correctAnswer', oreoQuestionFiveAnswerOne)


        oreoQuestionSix = Question.create
            questionText: "Where can you choose your side?"
        oreoQuestionSixAnswerOne = Answer.create
            answer: "Instagram"
        oreoQuestionSixAnswerTwo = Answer.create
            answer: "Facebook"
        oreoQuestionSixAnswerThree = Answer.create
            answer: "Twitter"
        oreoQuestionSixAnswerFour = Answer.create
            answer: "YouTube"

        oreoQuestionSix.addAnswers(
            oreoQuestionSixAnswerOne
            oreoQuestionSixAnswerTwo
            oreoQuestionSixAnswerThree
            oreoQuestionSixAnswerFour
        )

        oreoQuestionSix.set('correctAnswer', oreoQuestionSixAnswerOne)
        oreoTrivia.addQuestions(
            oreoQuestionOne
            oreoQuestionTwo
            oreoQuestionThree
            #oreoQuestionFour
            oreoQuestionFive
            oreoQuestionSix
        )

        # ---------------------------------------------------------------------- Reebok "Live With Fire"
        #
        #

        reebokTrivia = Trivia.create
            video: "media/video/Reebok_LiveWithFire"
            logo: "media/img/fixtures/brand_logos/logo_reebok.jpg"

        reebokQuestionOne = Question.create
            questionText: "Which activity did you NOT see?"
        reebokQuestionOneAnswerOne = Answer.create
            answer: "Powerlifting"
        reebokQuestionOneAnswerTwo = Answer.create
            answer: "Pushups"
        reebokQuestionOneAnswerThree = Answer.create
            answer: "Running up stairs"
        reebokQuestionOneAnswerFour = Answer.create
            answer: "Rope climbing"

        reebokQuestionOne.addAnswers(
            reebokQuestionOneAnswerOne
            reebokQuestionOneAnswerTwo
            reebokQuestionOneAnswerThree
            reebokQuestionOneAnswerFour
        )

        reebokQuestionOne.set('correctAnswer', reebokQuestionOneAnswerOne)

        reebokQuestionTwo = Question.create
            questionText: "It's not always about taking <span class='underscore'>______</span>"
        reebokQuestionTwoAnswerOne = Answer.create
            answer: "The easy route"
        reebokQuestionTwoAnswerTwo = Answer.create
            answer: "Your time"
        reebokQuestionTwoAnswerThree = Answer.create
            answer: "It slow"
        reebokQuestionTwoAnswerFour = Answer.create
            answer: "The most you can"

        reebokQuestionTwo.addAnswers(
            reebokQuestionTwoAnswerOne
            reebokQuestionTwoAnswerTwo
            reebokQuestionTwoAnswerThree
            reebokQuestionTwoAnswerFour
        )

        reebokQuestionTwo.set('correctAnswer', reebokQuestionTwoAnswerOne)



        reebokQuestionThree = Question.create
            questionText: "Life simply asks <span class='underscore'>______</span>"
        reebokQuestionThreeAnswerOne = Answer.create
            answer: "That you join it"
        reebokQuestionThreeAnswerTwo = Answer.create
            answer: "To give it everything"
        reebokQuestionThreeAnswerThree = Answer.create
            answer: "To train harder"
        reebokQuestionThreeAnswerFour = Answer.create
            answer: "That you strive"

        reebokQuestionThree.addAnswers(
            reebokQuestionThreeAnswerOne
            reebokQuestionThreeAnswerTwo
            reebokQuestionThreeAnswerThree
            reebokQuestionThreeAnswerFour
        )
        reebokQuestionThree.set('correctAnswer', reebokQuestionThreeAnswerOne)

        # reebokQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # reebokQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # reebokQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # reebokQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # reebokQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # reebokQuestionFour.addAnswers(
        #     reebokQuestionFourAnswerOne
        #     reebokQuestionFourAnswerTwo
        #     reebokQuestionFourAnswerThree
        #     reebokQuestionFourAnswerFour
        # )


        # reebokQuestionFour.set('correctAnswer', reebokQuestionFourAnswerOne)

        reebokQuestionFive = Question.create
            questionText: "Where were the stair runners?"
        reebokQuestionFiveAnswerOne = Answer.create
            answer: "Stadium"
        reebokQuestionFiveAnswerTwo = Answer.create
            answer: "Gym"
        reebokQuestionFiveAnswerThree = Answer.create
            answer: "Forest"
        reebokQuestionFiveAnswerFour = Answer.create
            answer: "Park"

        reebokQuestionFive.addAnswers(
            reebokQuestionFiveAnswerOne
            reebokQuestionFiveAnswerTwo
            reebokQuestionFiveAnswerThree
            reebokQuestionFiveAnswerFour
        )


        reebokQuestionFive.set('correctAnswer', reebokQuestionFiveAnswerOne)


        reebokQuestionSix = Question.create
            questionText: "What is the video's hashtag?"
        reebokQuestionSixAnswerOne = Answer.create
            answer: "#LiveWithFire"
        reebokQuestionSixAnswerTwo = Answer.create
            answer: "#Reebok"
        reebokQuestionSixAnswerThree = Answer.create
            answer: "#GetTraining"
        reebokQuestionSixAnswerFour = Answer.create
            answer: "#BringItOn"

        reebokQuestionSix.addAnswers(
            reebokQuestionSixAnswerOne
            reebokQuestionSixAnswerTwo
            reebokQuestionSixAnswerThree
            reebokQuestionSixAnswerFour
        )

        reebokQuestionSix.set('correctAnswer', reebokQuestionSixAnswerOne)
        reebokTrivia.addQuestions(
            reebokQuestionOne
            reebokQuestionTwo
            reebokQuestionThree
            #reebokQuestionFour
            reebokQuestionFive
            reebokQuestionSix
        )

        # ---------------------------------------------------------------------- McDonald's Fish McBites
        #
        #

        mcdsFishTrivia = Trivia.create
            video: "media/video/McDonalds"
            logo: "media/img/fixtures/brand_logos/logo_McDonalds.png"

        mcdsFishQuestionOne = Question.create
            questionText: "Mmm, what are those?"
        mcdsFishQuestionOneAnswerOne = Answer.create
            answer: "Fish McBites"
        mcdsFishQuestionOneAnswerTwo = Answer.create
            answer: "Chicken McBites"
        mcdsFishQuestionOneAnswerThree = Answer.create
            answer: "Filet-o-Fish"
        mcdsFishQuestionOneAnswerFour = Answer.create
            answer: "Chicken McNuggets"

        mcdsFishQuestionOne.addAnswers(
            mcdsFishQuestionOneAnswerOne
            mcdsFishQuestionOneAnswerTwo
            mcdsFishQuestionOneAnswerThree
            mcdsFishQuestionOneAnswerFour
        )

        mcdsFishQuestionOne.set('correctAnswer', mcdsFishQuestionOneAnswerOne)

        mcdsFishQuestionTwo = Question.create
            questionText: "New Fish McBites are succulent and <span class='underscore'>______</span> to perfection"
        mcdsFishQuestionTwoAnswerOne = Answer.create
            answer: "Breaded"
        mcdsFishQuestionTwoAnswerTwo = Answer.create
            answer: "Rounded"
        mcdsFishQuestionTwoAnswerThree = Answer.create
            answer: "Crispy"
        mcdsFishQuestionTwoAnswerFour = Answer.create
            answer: "Flavored"

        mcdsFishQuestionTwo.addAnswers(
            mcdsFishQuestionTwoAnswerOne
            mcdsFishQuestionTwoAnswerTwo
            mcdsFishQuestionTwoAnswerThree
            mcdsFishQuestionTwoAnswerFour
        )

        mcdsFishQuestionTwo.set('correctAnswer', mcdsFishQuestionTwoAnswerOne)



        mcdsFishQuestionThree = Question.create
            questionText: "What kind of fish is in Fish McBites?"
        mcdsFishQuestionThreeAnswerOne = Answer.create
            answer: "Alaskan Pollock"
        mcdsFishQuestionThreeAnswerTwo = Answer.create
            answer: "Norwegian Cod"
        mcdsFishQuestionThreeAnswerThree = Answer.create
            answer: "Red Snapper"
        mcdsFishQuestionThreeAnswerFour = Answer.create
            answer: "Louisiana Catfish"

        mcdsFishQuestionThree.addAnswers(
            mcdsFishQuestionThreeAnswerOne
            mcdsFishQuestionThreeAnswerTwo
            mcdsFishQuestionThreeAnswerThree
            mcdsFishQuestionThreeAnswerFour
        )
        mcdsFishQuestionThree.set('correctAnswer', mcdsFishQuestionThreeAnswerOne)

        # mcdsFishQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # mcdsFishQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # mcdsFishQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # mcdsFishQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # mcdsFishQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # mcdsFishQuestionFour.addAnswers(
        #     mcdsFishQuestionFourAnswerOne
        #     mcdsFishQuestionFourAnswerTwo
        #     mcdsFishQuestionFourAnswerThree
        #     mcdsFishQuestionFourAnswerFour
        # )


        # mcdsFishQuestionFour.set('correctAnswer', mcdsFishQuestionFourAnswerOne)

        mcdsFishQuestionFive = Question.create
            questionText: "Where are they eating Fish McBites?"
        mcdsFishQuestionFiveAnswerOne = Answer.create
            answer: "Log Cabin"
        mcdsFishQuestionFiveAnswerTwo = Answer.create
            answer: "City Apartment"
        mcdsFishQuestionFiveAnswerThree = Answer.create
            answer: "McDonald's Restaurant"
        mcdsFishQuestionFiveAnswerFour = Answer.create
            answer: "Park"

        mcdsFishQuestionFive.addAnswers(
            mcdsFishQuestionFiveAnswerOne
            mcdsFishQuestionFiveAnswerTwo
            mcdsFishQuestionFiveAnswerThree
            mcdsFishQuestionFiveAnswerFour
        )


        mcdsFishQuestionFive.set('correctAnswer', mcdsFishQuestionFiveAnswerOne)


        mcdsFishQuestionSix = Question.create
            questionText: "Unlike us, they're not going to <span class='underscore'>______</span> for long."
        mcdsFishQuestionSixAnswerOne = Answer.create
            answer: "Hang around"
        mcdsFishQuestionSixAnswerTwo = Answer.create
            answer: "Stay put"
        mcdsFishQuestionSixAnswerThree = Answer.create
            answer: "Stay fresh"
        mcdsFishQuestionSixAnswerFour = Answer.create
            answer: "Be here"

        mcdsFishQuestionSix.addAnswers(
            mcdsFishQuestionSixAnswerOne
            mcdsFishQuestionSixAnswerTwo
            mcdsFishQuestionSixAnswerThree
            mcdsFishQuestionSixAnswerFour
        )

        mcdsFishQuestionSix.set('correctAnswer', mcdsFishQuestionSixAnswerOne)
        mcdsFishTrivia.addQuestions(
            mcdsFishQuestionOne
            mcdsFishQuestionTwo
            mcdsFishQuestionThree
            #mcdsFishQuestionFour
            mcdsFishQuestionFive
            mcdsFishQuestionSix
        )

        # ---------------------------------------------------------------------- Capital One "Venture Family Reunion"
        #
        #

        caponeReunionTrivia = Trivia.create
            video: "media/video/CapitalOne_FamilyReunion"
            logo: "media/img/fixtures/brand_logos/logo_capitalone.png"

        caponeReunionQuestionOne = Question.create
            questionText: "What product was advertised?"
        caponeReunionQuestionOneAnswerOne = Answer.create
            answer: "Credit Card"
        caponeReunionQuestionOneAnswerTwo = Answer.create
            answer: "Personal Checking"
        caponeReunionQuestionOneAnswerThree = Answer.create
            answer: "Retirement Account"
        caponeReunionQuestionOneAnswerFour = Answer.create
            answer: "Online Banking"

        caponeReunionQuestionOne.addAnswers(
            caponeReunionQuestionOneAnswerOne
            caponeReunionQuestionOneAnswerTwo
            caponeReunionQuestionOneAnswerThree
            caponeReunionQuestionOneAnswerFour
        )

        caponeReunionQuestionOne.set('correctAnswer', caponeReunionQuestionOneAnswerOne)

        caponeReunionQuestionTwo = Question.create
            questionText: "What are the boys flying home for?"
        caponeReunionQuestionTwoAnswerOne = Answer.create
            answer: "Family Reunion"
        caponeReunionQuestionTwoAnswerTwo = Answer.create
            answer: "Homecoming Game"
        caponeReunionQuestionTwoAnswerThree = Answer.create
            answer: "Viking Olympics"
        caponeReunionQuestionTwoAnswerFour = Answer.create
            answer: "Renaissance Faire"

        caponeReunionQuestionTwo.addAnswers(
            caponeReunionQuestionTwoAnswerOne
            caponeReunionQuestionTwoAnswerTwo
            caponeReunionQuestionTwoAnswerThree
            caponeReunionQuestionTwoAnswerFour
        )

        caponeReunionQuestionTwo.set('correctAnswer', caponeReunionQuestionTwoAnswerOne)



        caponeReunionQuestionThree = Question.create
            questionText: "What is the Capital One Venture Card reward?"
        caponeReunionQuestionThreeAnswerOne = Answer.create
            answer: "Double Miles"
        caponeReunionQuestionThreeAnswerTwo = Answer.create
            answer: "Two-for-One Points"
        caponeReunionQuestionThreeAnswerThree = Answer.create
            answer: "1% Cash Back"
        caponeReunionQuestionThreeAnswerFour = Answer.create
            answer: "5% Gas Discount"

        caponeReunionQuestionThree.addAnswers(
            caponeReunionQuestionThreeAnswerOne
            caponeReunionQuestionThreeAnswerTwo
            caponeReunionQuestionThreeAnswerThree
            caponeReunionQuestionThreeAnswerFour
        )
        caponeReunionQuestionThree.set('correctAnswer', caponeReunionQuestionThreeAnswerOne)

        # caponeReunionQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # caponeReunionQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # caponeReunionQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # caponeReunionQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # caponeReunionQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # caponeReunionQuestionFour.addAnswers(
        #     caponeReunionQuestionFourAnswerOne
        #     caponeReunionQuestionFourAnswerTwo
        #     caponeReunionQuestionFourAnswerThree
        #     caponeReunionQuestionFourAnswerFour
        # )


        # caponeReunionQuestionFour.set('correctAnswer', caponeReunionQuestionFourAnswerOne)

        caponeReunionQuestionFive = Question.create
            questionText: "The Viking challenges Alec to what game?"
        caponeReunionQuestionFiveAnswerOne = Answer.create
            answer: "Dodgerock"
        caponeReunionQuestionFiveAnswerTwo = Answer.create
            answer: "Mom Toss"
        caponeReunionQuestionFiveAnswerThree = Answer.create
            answer: "Beard Curling"
        caponeReunionQuestionFiveAnswerFour = Answer.create
            answer: "Smash Face"

        caponeReunionQuestionFive.addAnswers(
            caponeReunionQuestionFiveAnswerOne
            caponeReunionQuestionFiveAnswerTwo
            caponeReunionQuestionFiveAnswerThree
            caponeReunionQuestionFiveAnswerFour
        )


        caponeReunionQuestionFive.set('correctAnswer', caponeReunionQuestionFiveAnswerOne)


        caponeReunionQuestionSix = Question.create
            questionText: "Whose mother did Alec meet?"
        caponeReunionQuestionSixAnswerOne = Answer.create
            answer: "Garth"
        caponeReunionQuestionSixAnswerTwo = Answer.create
            answer: "Hans"
        caponeReunionQuestionSixAnswerThree = Answer.create
            answer: "Lars"
        caponeReunionQuestionSixAnswerFour = Answer.create
            answer: "Bjorn"

        caponeReunionQuestionSix.addAnswers(
            caponeReunionQuestionSixAnswerOne
            caponeReunionQuestionSixAnswerTwo
            caponeReunionQuestionSixAnswerThree
            caponeReunionQuestionSixAnswerFour
        )

        caponeReunionQuestionSix.set('correctAnswer', caponeReunionQuestionSixAnswerOne)
        caponeReunionTrivia.addQuestions(
            caponeReunionQuestionOne
            caponeReunionQuestionTwo
            caponeReunionQuestionThree
            #caponeReunionQuestionFour
            caponeReunionQuestionFive
            caponeReunionQuestionSix
        )

        # ---------------------------------------------------------------------- Coca Cola Security Camera
        #
        #

        cokeCamTrivia = Trivia.create
            video: "media/video/FA_CocaCola_OpenHappiness_SecurityCameras"
            logo: "media/img/fixtures/brand_logos/logo_coke.jpg"

        cokeCamQuestionOne = Question.create
            questionText: "What captured these moments around the world?"
        cokeCamQuestionOneAnswerOne = Answer.create
            answer: "Security Cameras"
        cokeCamQuestionOneAnswerTwo = Answer.create
            answer: "iPhones"
        cokeCamQuestionOneAnswerThree = Answer.create
            answer: "Traffic Cops"
        cokeCamQuestionOneAnswerFour = Answer.create
            answer: "Photographers"

        cokeCamQuestionOne.addAnswers(
            cokeCamQuestionOneAnswerOne
            cokeCamQuestionOneAnswerTwo
            cokeCamQuestionOneAnswerThree
            cokeCamQuestionOneAnswerFour
        )

        cokeCamQuestionOne.set('correctAnswer', cokeCamQuestionOneAnswerOne)

        cokeCamQuestionTwo = Question.create
            questionText: "Which of these was NOT captured?"
        cokeCamQuestionTwoAnswerOne = Answer.create
            answer: "Surprising Tour Guides"
        cokeCamQuestionTwoAnswerTwo = Answer.create
            answer: "Music Addicts"
        cokeCamQuestionTwoAnswerThree = Answer.create
            answer: "People Stealing Kisses"
        cokeCamQuestionTwoAnswerFour = Answer.create
            answer: "Peaceful Warriors"

        cokeCamQuestionTwo.addAnswers(
            cokeCamQuestionTwoAnswerOne
            cokeCamQuestionTwoAnswerTwo
            cokeCamQuestionTwoAnswerThree
            cokeCamQuestionTwoAnswerFour
        )

        cokeCamQuestionTwo.set('correctAnswer', cokeCamQuestionTwoAnswerOne)



        cokeCamQuestionThree = Question.create
            questionText: "Where was the fire the Unexpected Fireman put out?"
        cokeCamQuestionThreeAnswerOne = Answer.create
            answer: "Car"
        cokeCamQuestionThreeAnswerTwo = Answer.create
            answer: "Picnic Table"
        cokeCamQuestionThreeAnswerThree = Answer.create
            answer: "Store"
        cokeCamQuestionThreeAnswerFour = Answer.create
            answer: "Yard"

        cokeCamQuestionThree.addAnswers(
            cokeCamQuestionThreeAnswerOne
            cokeCamQuestionThreeAnswerTwo
            cokeCamQuestionThreeAnswerThree
            cokeCamQuestionThreeAnswerFour
        )
        cokeCamQuestionThree.set('correctAnswer', cokeCamQuestionThreeAnswerOne)

        # cokeCamQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # cokeCamQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # cokeCamQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # cokeCamQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # cokeCamQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # cokeCamQuestionFour.addAnswers(
        #     cokeCamQuestionFourAnswerOne
        #     cokeCamQuestionFourAnswerTwo
        #     cokeCamQuestionFourAnswerThree
        #     cokeCamQuestionFourAnswerFour
        # )


        # cokeCamQuestionFour.set('correctAnswer', cokeCamQuestionFourAnswerOne)

        cokeCamQuestionFive = Question.create
            questionText: "What line in the song is repeated?"
        cokeCamQuestionFiveAnswerOne = Answer.create
            answer: "Give a little bit..."
        cokeCamQuestionFiveAnswerTwo = Answer.create
            answer: "Now's the time..."
        cokeCamQuestionFiveAnswerThree = Answer.create
            answer: "We need to share"
        cokeCamQuestionFiveAnswerFour = Answer.create
            answer: "We're on our way"

        cokeCamQuestionFive.addAnswers(
            cokeCamQuestionFiveAnswerOne
            cokeCamQuestionFiveAnswerTwo
            cokeCamQuestionFiveAnswerThree
            cokeCamQuestionFiveAnswerFour
        )


        cokeCamQuestionFive.set('correctAnswer', cokeCamQuestionFiveAnswerOne)


        cokeCamQuestionSix = Question.create
            questionText: "'Let's look at the world <span class='underscore'>______</span>'"
        cokeCamQuestionSixAnswerOne = Answer.create
            answer: "A Little Differently"
        cokeCamQuestionSixAnswerTwo = Answer.create
            answer: "In a New Way"
        cokeCamQuestionSixAnswerThree = Answer.create
            answer: "Together"
        cokeCamQuestionSixAnswerFour = Answer.create
            answer: "Through New Eyes"

        cokeCamQuestionSix.addAnswers(
            cokeCamQuestionSixAnswerOne
            cokeCamQuestionSixAnswerTwo
            cokeCamQuestionSixAnswerThree
            cokeCamQuestionSixAnswerFour
        )

        cokeCamQuestionSix.set('correctAnswer', cokeCamQuestionSixAnswerOne)
        cokeCamTrivia.addQuestions(
            cokeCamQuestionOne
            cokeCamQuestionTwo
            cokeCamQuestionThree
            #cokeCamQuestionFour
            cokeCamQuestionFive
            cokeCamQuestionSix
        )

        # ---------------------------------------------------------------------- Angel Soft TP Factory
        #
        #

        angelsoftTrivia = Trivia.create
            video: "media/video/Moxie_AngelSoft_TP_Factory.mov.ff"
            logo: "media/img/fixtures/brand_logos/logo_angelsoft.png"

        angelsoftQuestionOne = Question.create
            questionText: "What headgear were the babies wearing?"
        angelsoftQuestionOneAnswerOne = Answer.create
            answer: "Hardhats"
        angelsoftQuestionOneAnswerTwo = Answer.create
            answer: "Halos"
        angelsoftQuestionOneAnswerThree = Answer.create
            answer: "Baseball Caps"
        angelsoftQuestionOneAnswerFour = Answer.create
            answer: "None"

        angelsoftQuestionOne.addAnswers(
            angelsoftQuestionOneAnswerOne
            angelsoftQuestionOneAnswerTwo
            angelsoftQuestionOneAnswerThree
            angelsoftQuestionOneAnswerFour
        )

        angelsoftQuestionOne.set('correctAnswer', angelsoftQuestionOneAnswerOne)

        angelsoftQuestionTwo = Question.create
            questionText: "'It's now built with two <span class='underscore'>______</span> layers.'"
        angelsoftQuestionTwoAnswerOne = Answer.create
            answer: "Soft-shield"
        angelsoftQuestionTwoAnswerTwo = Answer.create
            answer: "Super-strong"
        angelsoftQuestionTwoAnswerThree = Answer.create
            answer: "Silky-soft"
        angelsoftQuestionTwoAnswerFour = Answer.create
            answer: "Ultra-smooth"

        angelsoftQuestionTwo.addAnswers(
            angelsoftQuestionTwoAnswerOne
            angelsoftQuestionTwoAnswerTwo
            angelsoftQuestionTwoAnswerThree
            angelsoftQuestionTwoAnswerFour
        )

        angelsoftQuestionTwo.set('correctAnswer', angelsoftQuestionTwoAnswerOne)



        angelsoftQuestionThree = Question.create
            questionText: "What did the wet Angel Soft suspend in the air?"
        angelsoftQuestionThreeAnswerOne = Answer.create
            answer: "Metal Nuts"
        angelsoftQuestionThreeAnswerTwo = Answer.create
            answer: "Babies"
        angelsoftQuestionThreeAnswerThree = Answer.create
            answer: "Marbles"
        angelsoftQuestionThreeAnswerFour = Answer.create
            answer: "Crayons"

        angelsoftQuestionThree.addAnswers(
            angelsoftQuestionThreeAnswerOne
            angelsoftQuestionThreeAnswerTwo
            angelsoftQuestionThreeAnswerThree
            angelsoftQuestionThreeAnswerFour
        )
        angelsoftQuestionThree.set('correctAnswer', angelsoftQuestionThreeAnswerOne)

        # angelsoftQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # angelsoftQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # angelsoftQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # angelsoftQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # angelsoftQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # angelsoftQuestionFour.addAnswers(
        #     angelsoftQuestionFourAnswerOne
        #     angelsoftQuestionFourAnswerTwo
        #     angelsoftQuestionFourAnswerThree
        #     angelsoftQuestionFourAnswerFour
        # )


        # angelsoftQuestionFour.set('correctAnswer', angelsoftQuestionFourAnswerOne)

        angelsoftQuestionFive = Question.create
            questionText: "Where does the water fall from?"
        angelsoftQuestionFiveAnswerOne = Answer.create
            answer: "Cloud"
        angelsoftQuestionFiveAnswerTwo = Answer.create
            answer: "Watering Can"
        angelsoftQuestionFiveAnswerThree = Answer.create
            answer: "Sprinkler"
        angelsoftQuestionFiveAnswerFour = Answer.create
            answer: "Hose"

        angelsoftQuestionFive.addAnswers(
            angelsoftQuestionFiveAnswerOne
            angelsoftQuestionFiveAnswerTwo
            angelsoftQuestionFiveAnswerThree
            angelsoftQuestionFiveAnswerFour
        )


        angelsoftQuestionFive.set('correctAnswer', angelsoftQuestionFiveAnswerOne)


        angelsoftQuestionSix = Question.create
            questionText: "How many rolls were in each Angel Soft package?"
        angelsoftQuestionSixAnswerOne = Answer.create
            answer: "6"
        angelsoftQuestionSixAnswerTwo = Answer.create
            answer: "4"
        angelsoftQuestionSixAnswerThree = Answer.create
            answer: "8"
        angelsoftQuestionSixAnswerFour = Answer.create
            answer: "2"

        angelsoftQuestionSix.addAnswers(
            angelsoftQuestionSixAnswerOne
            angelsoftQuestionSixAnswerTwo
            angelsoftQuestionSixAnswerThree
            angelsoftQuestionSixAnswerFour
        )

        angelsoftQuestionSix.set('correctAnswer', angelsoftQuestionSixAnswerOne)
        angelsoftTrivia.addQuestions(
            angelsoftQuestionOne
            angelsoftQuestionTwo
            angelsoftQuestionThree
            #angelsoftQuestionFour
            angelsoftQuestionFive
            angelsoftQuestionSix
        )

        # ---------------------------------------------------------------------- Revlone Emma Stone "Naked"
        #
        #

        revlonEmmaTrivia = Trivia.create
            video: "media/video/Revlon_Naked_Emma"
            logo: "media/img/fixtures/brand_logos/revlon_logo.jpg"

        revlonEmmaQuestionOne = Question.create
            questionText: "'Of course, every girl <span class='underscore'>______</span>.'"
        revlonEmmaQuestionOneAnswerOne = Answer.create
            answer: "Has secrets"
        revlonEmmaQuestionOneAnswerTwo = Answer.create
            answer: "Needs a little help"
        revlonEmmaQuestionOneAnswerThree = Answer.create
            answer: "Is beautiful"
        revlonEmmaQuestionOneAnswerFour = Answer.create
            answer: "Likes to be natural"

        revlonEmmaQuestionOne.addAnswers(
            revlonEmmaQuestionOneAnswerOne
            revlonEmmaQuestionOneAnswerTwo
            revlonEmmaQuestionOneAnswerThree
            revlonEmmaQuestionOneAnswerFour
        )

        revlonEmmaQuestionOne.set('correctAnswer', revlonEmmaQuestionOneAnswerOne)

        revlonEmmaQuestionTwo = Question.create
            questionText: "What did Emma Stone do for 6 months as a baby?"
        revlonEmmaQuestionTwoAnswerOne = Answer.create
            answer: "Scream"
        revlonEmmaQuestionTwoAnswerTwo = Answer.create
            answer: "Talk"
        revlonEmmaQuestionTwoAnswerThree = Answer.create
            answer: "Eat"
        revlonEmmaQuestionTwoAnswerFour = Answer.create
            answer: "Sleep"

        revlonEmmaQuestionTwo.addAnswers(
            revlonEmmaQuestionTwoAnswerOne
            revlonEmmaQuestionTwoAnswerTwo
            revlonEmmaQuestionTwoAnswerThree
            revlonEmmaQuestionTwoAnswerFour
        )

        revlonEmmaQuestionTwo.set('correctAnswer', revlonEmmaQuestionTwoAnswerOne)



        revlonEmmaQuestionThree = Question.create
            questionText: "'Revlon Nearly Naked makeup is <span class='underscore'>______</span>.'"
        revlonEmmaQuestionThreeAnswerOne = Answer.create
            answer: "Refreshing and light"
        revlonEmmaQuestionThreeAnswerTwo = Answer.create
            answer: "Nearly invisible"
        revlonEmmaQuestionThreeAnswerThree = Answer.create
            answer: "Glowing and rejuvenating"
        revlonEmmaQuestionThreeAnswerFour = Answer.create
            answer: "Pure and beautiful"

        revlonEmmaQuestionThree.addAnswers(
            revlonEmmaQuestionThreeAnswerOne
            revlonEmmaQuestionThreeAnswerTwo
            revlonEmmaQuestionThreeAnswerThree
            revlonEmmaQuestionThreeAnswerFour
        )
        revlonEmmaQuestionThree.set('correctAnswer', revlonEmmaQuestionThreeAnswerOne)

        # revlonEmmaQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # revlonEmmaQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # revlonEmmaQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # revlonEmmaQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # revlonEmmaQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # revlonEmmaQuestionFour.addAnswers(
        #     revlonEmmaQuestionFourAnswerOne
        #     revlonEmmaQuestionFourAnswerTwo
        #     revlonEmmaQuestionFourAnswerThree
        #     revlonEmmaQuestionFourAnswerFour
        # )


        # revlonEmmaQuestionFour.set('correctAnswer', revlonEmmaQuestionFourAnswerOne)

        revlonEmmaQuestionFive = Question.create
            questionText: "To Emma, what is beautiful?"
        revlonEmmaQuestionFiveAnswerOne = Answer.create
            answer: "Funny"
        revlonEmmaQuestionFiveAnswerTwo = Answer.create
            answer: "Natural"
        revlonEmmaQuestionFiveAnswerThree = Answer.create
            answer: "Clear"
        revlonEmmaQuestionFiveAnswerFour = Answer.create
            answer: "Light"

        revlonEmmaQuestionFive.addAnswers(
            revlonEmmaQuestionFiveAnswerOne
            revlonEmmaQuestionFiveAnswerTwo
            revlonEmmaQuestionFiveAnswerThree
            revlonEmmaQuestionFiveAnswerFour
        )


        revlonEmmaQuestionFive.set('correctAnswer', revlonEmmaQuestionFiveAnswerOne)


        revlonEmmaQuestionSix = Question.create
            questionText: "'Dare to be <span class='underscore'>______</span>.'"
        revlonEmmaQuestionSixAnswerOne = Answer.create
            answer: "Revlon"
        revlonEmmaQuestionSixAnswerTwo = Answer.create
            answer: "Beautiful"
        revlonEmmaQuestionSixAnswerThree = Answer.create
            answer: "Yourself"
        revlonEmmaQuestionSixAnswerFour = Answer.create
            answer: "Wild"

        revlonEmmaQuestionSix.addAnswers(
            revlonEmmaQuestionSixAnswerOne
            revlonEmmaQuestionSixAnswerTwo
            revlonEmmaQuestionSixAnswerThree
            revlonEmmaQuestionSixAnswerFour
        )

        revlonEmmaQuestionSix.set('correctAnswer', revlonEmmaQuestionSixAnswerOne)
        revlonEmmaTrivia.addQuestions(
            revlonEmmaQuestionOne
            revlonEmmaQuestionTwo
            revlonEmmaQuestionThree
            #revlonEmmaQuestionFour
            revlonEmmaQuestionFive
            revlonEmmaQuestionSix
        )

        # ---------------------------------------------------------------------- Purina Beggin' Strips
        #
        #

        purinaBegginStripsTrivia = Trivia.create
            video: "media/video/BegginStrips_AroundTheWorld"
            logo: "media/img/fixtures/brand_logos/purina_beggin_logo.jpg"

        purinaBegginStripsQuestionOne = Question.create
            questionText: "What is this treat called?"
        purinaBegginStripsQuestionOneAnswerOne = Answer.create
            answer: "Beggin' Strips"
        purinaBegginStripsQuestionOneAnswerTwo = Answer.create
            answer: "Bacon Strips"
        purinaBegginStripsQuestionOneAnswerThree = Answer.create
            answer: "Beggin' Bites"
        purinaBegginStripsQuestionOneAnswerFour = Answer.create
            answer: "Bacon Bites"

        purinaBegginStripsQuestionOne.addAnswers(
            purinaBegginStripsQuestionOneAnswerOne
            purinaBegginStripsQuestionOneAnswerTwo
            purinaBegginStripsQuestionOneAnswerThree
            purinaBegginStripsQuestionOneAnswerFour
        )

        purinaBegginStripsQuestionOne.set('correctAnswer', purinaBegginStripsQuestionOneAnswerOne)

        purinaBegginStripsQuestionTwo = Question.create
            questionText: "The poodle is in front of what landmark?"
        purinaBegginStripsQuestionTwoAnswerOne = Answer.create
            answer: "Eiffel Tower"
        purinaBegginStripsQuestionTwoAnswerTwo = Answer.create
            answer: "Grand Canyon"
        purinaBegginStripsQuestionTwoAnswerThree = Answer.create
            answer: "Leaning Tower of Pisa"
        purinaBegginStripsQuestionTwoAnswerFour = Answer.create
            answer: "Niagara Falls"

        purinaBegginStripsQuestionTwo.addAnswers(
            purinaBegginStripsQuestionTwoAnswerOne
            purinaBegginStripsQuestionTwoAnswerTwo
            purinaBegginStripsQuestionTwoAnswerThree
            purinaBegginStripsQuestionTwoAnswerFour
        )

        purinaBegginStripsQuestionTwo.set('correctAnswer', purinaBegginStripsQuestionTwoAnswerOne)



        purinaBegginStripsQuestionThree = Question.create
            questionText: "'I'd get it myself but <span class='underscore'>______</span>!'"
        purinaBegginStripsQuestionThreeAnswerOne = Answer.create
            answer: "I don't have thumbs"
        purinaBegginStripsQuestionThreeAnswerTwo = Answer.create
            answer: "I'm a dog"
        purinaBegginStripsQuestionThreeAnswerThree = Answer.create
            answer: "I can't find the bag"
        purinaBegginStripsQuestionThreeAnswerFour = Answer.create
            answer: "I don't know how"

        purinaBegginStripsQuestionThree.addAnswers(
            purinaBegginStripsQuestionThreeAnswerOne
            purinaBegginStripsQuestionThreeAnswerTwo
            purinaBegginStripsQuestionThreeAnswerThree
            purinaBegginStripsQuestionThreeAnswerFour
        )
        purinaBegginStripsQuestionThree.set('correctAnswer', purinaBegginStripsQuestionThreeAnswerOne)

        # purinaBegginStripsQuestionFour = Question.create
        #     questionText: "What does PBS stand for?"
        # purinaBegginStripsQuestionFourAnswerOne = Answer.create
        #     answer: "Public Broadcasting Service"
        # purinaBegginStripsQuestionFourAnswerTwo = Answer.create
        #     answer: "People’s Broadcasting System"
        # purinaBegginStripsQuestionFourAnswerThree = Answer.create
        #     answer: "Public Broadcasting System"
        # purinaBegginStripsQuestionFourAnswerFour = Answer.create
        #     answer: "Positively Best Shows"


        # purinaBegginStripsQuestionFour.addAnswers(
        #     purinaBegginStripsQuestionFourAnswerOne
        #     purinaBegginStripsQuestionFourAnswerTwo
        #     purinaBegginStripsQuestionFourAnswerThree
        #     purinaBegginStripsQuestionFourAnswerFour
        # )


        # purinaBegginStripsQuestionFour.set('correctAnswer', purinaBegginStripsQuestionFourAnswerOne)

        purinaBegginStripsQuestionFive = Question.create
            questionText: "What landmark is NOT in the video?"
        purinaBegginStripsQuestionFiveAnswerOne = Answer.create
            answer: "Mount Rushmore"
        purinaBegginStripsQuestionFiveAnswerTwo = Answer.create
            answer: "Great Wall of China"
        purinaBegginStripsQuestionFiveAnswerThree = Answer.create
            answer: "Buckingham Palace"
        purinaBegginStripsQuestionFiveAnswerFour = Answer.create
            answer: "Taj Mahal"

        purinaBegginStripsQuestionFive.addAnswers(
            purinaBegginStripsQuestionFiveAnswerOne
            purinaBegginStripsQuestionFiveAnswerTwo
            purinaBegginStripsQuestionFiveAnswerThree
            purinaBegginStripsQuestionFiveAnswerFour
        )


        purinaBegginStripsQuestionFive.set('correctAnswer', purinaBegginStripsQuestionFiveAnswerOne)


        purinaBegginStripsQuestionSix = Question.create
            questionText: "'Proudly produced in Clinton, IA & <span class='underscore'>______</span>.'"
        purinaBegginStripsQuestionSixAnswerOne = Answer.create
            answer: "Dunkirk, NY"
        purinaBegginStripsQuestionSixAnswerTwo = Answer.create
            answer: "Topeka, KS"
        purinaBegginStripsQuestionSixAnswerThree = Answer.create
            answer: "Harrisburg, PA"
        purinaBegginStripsQuestionSixAnswerFour = Answer.create
            answer: "Richmond, VA"

        purinaBegginStripsQuestionSix.addAnswers(
            purinaBegginStripsQuestionSixAnswerOne
            purinaBegginStripsQuestionSixAnswerTwo
            purinaBegginStripsQuestionSixAnswerThree
            purinaBegginStripsQuestionSixAnswerFour
        )

        purinaBegginStripsQuestionSix.set('correctAnswer', purinaBegginStripsQuestionSixAnswerOne)
        purinaBegginStripsTrivia.addQuestions(
            purinaBegginStripsQuestionOne
            purinaBegginStripsQuestionTwo
            purinaBegginStripsQuestionThree
            #purinaBegginStripsQuestionFour
            purinaBegginStripsQuestionFive
            purinaBegginStripsQuestionSix
        )

        return {
            testAnswer1: testAnswer1
            testAnswer2: testAnswer2
            testAnswer3: testAnswer3
            testAnswer4: testAnswer4

            testQuestion1: testQuestion1
            testQuestion2: Question.create
                questionText: "What dino doesn't eat meat"

            testQuestion3: Question.create
                questionText: "What's the deal with airplane food?"

            testTrivia: testTrivia

            allStateQuestions: [
                allStateQuestionOne
                allStateQuestionTwo
                allStateQuestionThree
                allStateQuestionFour
                allStateQuestionFive
                allStateQuestionSix
            ]
            allStateTrivia: allStateTrivia
            amexQuestions: [
                amexQuestionOne
                amexQuestionTwo
                amexQuestionThree
                #amexQuestionFour
                amexQuestionFive
                amexQuestionSix
            ]
            amexTrivia: amexTrivia
            oreoTrivia: oreoTrivia
            reebokTrivia: reebokTrivia
            mcdsFishTrivia: mcdsFishTrivia
            caponeReunionTrivia: caponeReunionTrivia
            cokeCamTrivia:cokeCamTrivia
            angelsoftTrivia:angelsoftTrivia
            revlonEmmaTrivia:revlonEmmaTrivia
            purinaBegginStripsTrivia:purinaBegginStripsTrivia
        }
    return {makeData:makeData}
