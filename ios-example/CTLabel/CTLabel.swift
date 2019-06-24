import UIKit

@IBDesignable
class CTLabel: UILabel {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        let transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1, y: -1)
        context.concatenate(transform)
        //TODO font size 見た目はぽくなったが。。。
        let font = UIFont.systemFont(ofSize: 50)
        let attrString = NSAttributedString(string: self.text ?? "", attributes: [
                .verticalGlyphForm: true,
                .font: font
            ])
        let attrRect = CGRect(x: 0, y: 0, width: attrString.size().width, height: attrString.size().height)
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString)
        let path = CGPath(rect: attrRect, transform: nil)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(), path, nil)
        CTFrameDraw(frame, context)
    }

}
