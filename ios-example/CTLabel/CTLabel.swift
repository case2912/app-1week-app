import UIKit

@IBDesignable
class CTLabel: UILabel {
    override func draw(_ rect: CGRect) {
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
        //labelの横幅と文字列の横幅を比較して、labelの文字の大きさをラベルの大きさまで合わせる fontSizeとrectWidthで比較しないと何故か表示されない。。。
        var fontSize: CGFloat = 1
        while rect.width > fontSize {
            let fontRef = CTFontCreateWithName("AoyagiSosekiFont2OTF" as CFString, fontSize, nil)
            stringAttrs = [
                kCTFontAttributeName as NSAttributedString.Key: fontRef,
                NSAttributedString.Key.verticalGlyphForm: true,
            ]
            astr = NSAttributedString(string: self.text ?? "", attributes: stringAttrs)
            fontSize += 1

        }
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
