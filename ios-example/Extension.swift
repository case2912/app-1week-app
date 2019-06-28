import Foundation
import UIKit
extension UIFont {
    static let aoyagiSosekiFontString = "AoyagiSosekiFont2OTF"
}
extension UINavigationController {
    func loadViewController(identifier: String, completion: ((_ controller: UIViewController) -> Void)?) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return }
        completion?(controller)
        self.pushViewController(controller, animated: true)
    }
    func loadModalViewController(identifier: String, completion: ((_ controller: UIViewController) -> Void)?) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return }
        completion?(controller)
        self.present(controller, animated: true, completion: nil)
    }

}
extension UINavigationItem {
    func setBackButtonItem() {
        let backButton = UIBarButtonItem(title: "戻る", style: .done, target: self, action: nil)
        backButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: UIFont.aoyagiSosekiFontString, size: 30)!,
            ], for: .normal)
        backButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: UIFont.aoyagiSosekiFontString, size: 30)!,
            ], for: .highlighted)
        self.backBarButtonItem = backButton
    }
}
extension UIColor {
    static let background = UIColor(patternImage: UIImage(named: "japanese-paper")!)
    static let primary = UIColor(patternImage: UIImage(named: "japanese-paper-red")!)
}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}
public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }

extension UserDefaults {
    static let clientUUIDString = "client-uuid"
}
