document.addEventListener 'DOMContentLoaded', ->
  ace = require('brace')
  require('brace/mode/javascript')
  require('brace/theme/monokai')

  editor = ace.edit('editor')
  editor.getSession().setMode('ace/mode/javascript')
  editor.setTheme('ace/theme/monokai')