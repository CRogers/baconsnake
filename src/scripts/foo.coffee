document.addEventListener 'DOMContentLoaded', ->
  ace = require('brace')
  require('brace/mode/coffee')
  require('brace/mode/html')
  require('brace/theme/monokai')
  ###
  editorCoffee = ace.edit('editor-coffee')
  editorCoffee.getSession().setMode('ace/mode/coffee')
  editorCoffee.setTheme('ace/theme/monokai')

  editorHtml = ace.edit('editor-html')
  editorHtml.getSession().setMode('ace/mode/html')
  editorHtml.setTheme('ace/theme/monokai')###