import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "japanese-paper-red")!)
        navigationBar.backgroundColor = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AoyagiSosekiFont2OTF", size: 18)!,
        ]
    }

}
