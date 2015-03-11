isEven = (num) -> num % 2 == 0

filterMap = (stream) ->
  stream
  .filter isEven
  .map (num) -> num * 10

module.exports = filterMap