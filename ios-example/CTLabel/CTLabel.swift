import UIKit

@IBDesignable
class CTLabel: UILabel {
    override func draw(_ rect: CGRect) {
        print(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        context.translateBy(x: 0, y: self.bounds.size.height)
        context.scaleBy(x: 1, y: -1)
        var stringAttrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.verticalGlyphForm: true,
        ]
        var astr = NSAttributedString(string: self.text ?? "", attributes: stringAttrs)
        //labelの横幅と文字列の横幅を比較して、labelの文字の大きさをラベルの大きさまで合わせる このときastrのheightは実際のwidth(縦書きのため)
        var fontSize: CGFloat = 10
        while rect.width > astr.size().height {
            let font = UIFont.systemFont(ofSize: fontSize)
            stringAttrs = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.verticalGlyphForm: true,
            ]
            astr = NSAttributedString(string: self.text ?? "", attributes: stringAttrs)
            fontSize += 1
        }
        print(astr.size().height)
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
