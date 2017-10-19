import UIKit

protocol Node: TreeRenderable {
  func evaluate() -> Double
}

extension Node {
  var maxHeight: Int {
    return 1
  }
}

struct ValueNode: Node {
  var value: Double
  
  func evaluate() -> Double {
    return value
  }
  
  var text: String? {
    return "\(Int(value))"
  }
}

protocol OperationNode: Node {
  var leftChild: Node { get }
  var rightChild: Node { get }
}

extension OperationNode {
  var maxHeight: Int {
    return max(leftChild.maxHeight, rightChild.maxHeight) + 1
  }
  
  func render(into context: CGContext, at center: CGPoint) {
    draw(child: leftChild, direction: .left, into: context, from: center)
    draw(child: rightChild, direction: .right, into: context, from: center)
    draw(into: context, at: center)
  }
}

struct AddNode: OperationNode {
  var leftChild: Node
  var rightChild: Node

  func evaluate() -> Double {
    return leftChild.evaluate() + rightChild.evaluate()
  }
  
  var text: String? {
    return "+"
  }
}

struct MultiplyNode: OperationNode {
  var leftChild: Node
  var rightChild: Node

  func evaluate() -> Double {
    return leftChild.evaluate() * rightChild.evaluate()
  }
  
  var text: String? {
    return "*"
  }
}

struct PowerNode: OperationNode {
  var leftChild: Node
  var rightChild: Node
  
  func evaluate() -> Double {
    return pow(leftChild.evaluate(), rightChild.evaluate())
  }
  
  var text: String? {
    return "^"
  }
}

let formula =
  PowerNode(leftChild:
  AddNode(
    leftChild:
    MultiplyNode(
      leftChild: ValueNode(value: 2),
      rightChild: ValueNode(value: 3)
    ),
    rightChild:
    ValueNode(value: 4)
    ), rightChild: ValueNode(value: 2))

print(formula.evaluate())

formula.render()
