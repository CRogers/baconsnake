h = require('virtual-dom/h')
diff = require('virtual-dom/diff')
patch = require('virtual-dom/patch')
createElement = require('virtual-dom/create-element')

Bacon = require('baconjs')

window.Bacon = Bacon

vdomBaconjsRenderder = (parentElement, vtreeStream) ->
  domNode = vtreeStream
    .take(1)
    .map createElement
    .toProperty()

  domNode.onValue (rootNode) ->
    parentElement.appendChild(rootNode)

  vtreeStream
    .slidingWindow(2, 2)
    .map ([oldTree, newTree]) -> diff(oldTree, newTree)
    .combine domNode, (patches, rootNode) -> [patches, rootNode]
    .onValue ([patches, rootNode]) ->
      window.requestAnimationFrame ->
        patch(rootNode, patches)

module.exports = vdomBaconjsRenderder