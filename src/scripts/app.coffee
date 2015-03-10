require('./libsetup')
require('./view')
{inputs, Keys} = require('./inputs')

lefts = inputs.filter (event) -> event.which == Keys.LEFT
rights = inputs.filter (event) -> event.which == Keys.RIGHT

lefts.map('left').log()
rights.map('right').log()