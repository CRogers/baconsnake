/// <reference path="../typings/tsd.d.ts" />

import { h, diff, patch, create } from 'virtual-dom'

export default function vdomBaconjsRenderer(
    parentElement: Element,
    vtreeStream: Bacon.EventStream<any, VirtualDOM.VTree>) {

  let domNode = vtreeStream
      .take(1)
      .map(create)
      .toProperty();

  domNode.onValue(rootNode =>
          parentElement.appendChild(rootNode)
  );

  vtreeStream
      .slidingWindow(2, 2)
      .map(treeList => diff(treeList[0], treeList[1]))
      .combine(domNode, (patches, rootNode) => ({patches, rootNode}))
      .onValue(({patches, rootNode}) => {
        window.requestAnimationFrame(() => patch(rootNode, patches))
      });
}