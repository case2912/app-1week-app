import Foundation
import UIKit

class CustomUIButton :UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .primary
        self.titleLabel?.font = UIFont(name: UIFont.aoyagiSosekiFontString, size: 24)
        self.tintColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 1
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
