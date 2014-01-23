require ['ember',"cs!unlockable/unlockable"], (Em, Unlockable) ->
    describe "Main Unlockable application", () ->
        beforeEach () ->
            Em.run.begin()

        it "should include the ember framework", () ->
            Em.should.not.be.undefined
        it "should include the unlockable application", () ->
            Unlockable.toString().should.be.equal("Unlockable")
