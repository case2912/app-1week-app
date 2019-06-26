import Foundation
import UIKit

class CustomUIView : UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "japanese-paper-red")!)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 1
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
