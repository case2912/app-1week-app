import Foundation
import UIKit

class BaseLoadViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .background
        indicator.startAnimating()
        User.user(){ () -> Void in
            self.navigationController?.loadViewController(identifier: RootViewController.className, completion: nil)
        }
    }
}
