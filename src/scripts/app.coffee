require('./libsetup')
require('./view')
{inputs, Keys} = require('./inputs')

property = (prop, submatcher) ->
  return (object) -> submatcher(object[prop])

equalTo = (expectedValue) ->
  return (value) -> value == expectedValue

isKey = (key) -> property('which', equalTo(key))

lefts = inputs.filter isKey(Keys.LEFT)
rights = inputs.filter isKey(Keys.RIGHT)

lefts.map('left').log()
rights.map('right').log()