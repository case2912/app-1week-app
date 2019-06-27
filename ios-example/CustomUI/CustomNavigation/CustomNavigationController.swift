import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .primary
        navigationBar.backgroundColor = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: UIFont.aoyagiSosekiFontString, size: 18)!,
        ]
    }

}
