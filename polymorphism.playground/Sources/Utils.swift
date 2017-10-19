import UIKit

extension CGRect {
  init(center: CGPoint, size: CGSize) {
    self.init(origin: CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2), size: size)
  }
}

extension String {
  func draw(centeredIn rect: CGRect, withAttributes attrs: [NSAttributedStringKey : Any]) {
    let text = self as NSString
    let boundingRect = text.boundingRect(
      with: rect.size,
      options: [.usesLineFragmentOrigin],
      attributes: attrs,
      context: nil)
    let textRect = rect.insetBy(
      dx: (rect.size.width - boundingRect.size.width) / 2,
      dy: (rect.size.height - boundingRect.size.height) / 2)
    
    text.draw(
      with: textRect,
      options: [.usesLineFragmentOrigin],
      attributes: attrs,
      context: nil)
  }
}
