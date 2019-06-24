//
//  CTView.swift
//  ios-example
//
//  Created by Kento Shiroyama on 2019/06/20.
//  Copyright © 2019 Kento Shiroyama. All rights reserved.
//

import UIKit

class CTView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        let transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1, y: -1)
        context.concatenate(transform)

        let attrString = NSAttributedString(string: "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやぃゆぇよらりるれろわゐぅゑを", attributes: [
                .verticalGlyphForm: true
            ])
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString)
        let path = CGPath(rect: rect.applying(transform.inverted())
            , transform: nil)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(), path, nil)
        CTFrameDraw(frame, context)
    }
}
