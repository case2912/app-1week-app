import Foundation
import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var uuidLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        view.backgroundColor = .background
        uuidLabel.text = User.uuid()
    }
}
