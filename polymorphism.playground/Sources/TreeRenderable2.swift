import UIKit

let nodeSize = CGSize(width: 44, height: 44)
let nodeSpacing = (horizontal: 1.5 as CGFloat, vertical: 1.5 as CGFloat)
let nodeTextAttributes: [NSAttributedStringKey : Any] = [
  .font: UIFont.boldSystemFont(ofSize: 20),
  .foregroundColor: UIColor.white,
]

public extension TreeRenderable {
  private var bounds: CGRect {
    let h = CGFloat(maxHeight)
    let width = pow(2, CGFloat(h - 1)) * nodeSize.width * nodeSpacing.horizontal
    let height = h * nodeSize.height * nodeSpacing.vertical
    return CGRect(origin: .zero, size:CGSize(width: width, height: height))
  }
  
  var text: String? {
    return nil
  }
  
  func render(into context: CGContext, at center: CGPoint) {
    draw(into: context, at: center)
  }
}

public enum TreeRenderableDirection {
  case left
  case right
}

public extension TreeRenderable {
  
  /// Renders a visualization of the tree
  ///
  /// - Returns: An image of the tree visualized
  func render() -> UIImage {
    let center = CGPoint(
      x: bounds.midX,
      y: nodeSize.height / 2 * nodeSpacing.vertical
    )
    return UIGraphicsImageRenderer(bounds: bounds).image() {
      context in
      self.render(into: context.cgContext, at: center)
    }
  }
  
  /// Draws the current node
  ///
  /// - Parameters:
  ///   - context: The core graphics context to render into
  ///   - center: The position to render the current node
  public func draw(into context: CGContext, at center: CGPoint) {
    let rect = CGRect(center: center, size: nodeSize)
    UIColor.black.setFill()
    context.fillEllipse(in: rect)
    text?.draw(centeredIn: rect, withAttributes: nodeTextAttributes)
  }
  
  
  /// Draws a child of the current node
  ///
  /// - Parameters:
  ///   - child: The child node to draw
  ///   - direction: The orientation from the current node
  ///   - context: The core graphics context to render into
  ///   - center: The position to render the current node
  public func draw(child: TreeRenderable, direction: TreeRenderableDirection, into context: CGContext, from center: CGPoint) {
    let offset = pow(2, CGFloat(maxHeight) - 2) * nodeSize.width / 2 * nodeSpacing.horizontal * (direction == .left ? -1 : 1)
    let nextCenter = CGPoint(x: center.x + offset, y: center.y + nodeSize.height * nodeSpacing.vertical)
    UIColor.black.set()
    context.strokeLineSegments(between: [center, nextCenter])
    child.render(into: context, at: nextCenter)
  }
}
