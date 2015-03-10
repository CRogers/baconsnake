h = require('virtual-dom/h')
diff = require('virtual-dom/diff')
patch = require('virtual-dom/patch')
createElement = require('virtual-dom/create-element')

Bacon = require('baconjs')

window.Bacon = Bacon

vdomBaconjsRenderder = (parentElement, vtreeStream) ->
  domNode = vtreeStream
    .take(1)
    .map (tree) ->
      rootNode = createElement(tree)
      parentElement.appendChild(rootNode)
      return rootNode
    .toProperty()

  vtreeStream
    .slidingWindow(2, 2)
    .map ([oldTree, newTree]) -> diff(oldTree, newTree)
    .combine domNode, (patches, rootNode) -> [patches, rootNode]
    .onValue ([patches, rootNode]) ->
      patch(rootNode, patches)

tree = h('div', {className: 'foo'})

stream = Bacon.repeatedly(1000, [tree])

document.addEventListener 'DOMContentLoaded', ->
  vdomBaconjsRenderder(document.body, stream)