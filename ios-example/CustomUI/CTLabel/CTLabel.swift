import UIKit
class CTLabel: UILabel {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        context.translateBy(x: 0, y: self.bounds.size.height)
        context.scaleBy(x: 1, y: -1)
        let astr = NSAttributedString(string: self.text ?? "", attributes: [
            kCTFontAttributeName as NSAttributedString.Key: CTFontCreateWithName(UIFont.aoyagiSosekiFontString as CFString, floor(rect.width - 1) as CGFloat, nil),
            NSAttributedString.Key.verticalGlyphForm: true,
            ])
        let frameSetter = CTFramesetterCreateWithAttributedString(astr)
        let newRect = CGRect(x: 2 * rect.origin.x, y: 2 * rect.origin.y, width: rect.width, height: rect.height)
        let path = CGPath(rect: newRect, transform: nil)
        let frameAttrs = [
            kCTFrameProgressionAttributeName: CTFrameProgression.rightToLeft.rawValue,
        ]
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(), path, frameAttrs as CFDictionary)
        CTFrameDraw(frame, context)
    }
}
