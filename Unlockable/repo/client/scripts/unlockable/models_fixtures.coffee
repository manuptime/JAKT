define ['cs!unlockable/models'], (Models) ->
    {User, Game, Frame} = Models
    makeData = () ->
        testUser = User.create
            id: 1
            sessionId: 1

        return {
            testUser: testUser
        }
    return {makeData:makeData}