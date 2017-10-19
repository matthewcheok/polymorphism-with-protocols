import UIKit

public protocol TreeRenderable {
  /// The height of the subtree beginning at this node
  var maxHeight: Int { get }
  
  /// The text to be displayed visually in the node
  var text: String? { get }
  
  /// Renders the subtree beginning at this node.
  /// Implement by calling the relevant draw functions.
  ///
  /// - Parameters:
  ///   - context: The core graphics context to render into
  ///   - center: The position to render the current node
  func render(into context: CGContext, at center: CGPoint)
}
