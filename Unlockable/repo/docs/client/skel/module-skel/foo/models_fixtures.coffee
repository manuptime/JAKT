define ['cs!./models'], (FramesModels) ->
    {Foo} = FooModels
    makeData = () ->
        testFoo = Foo.create()

        return {
            testFoo
        }
    return {makeData:makeData}