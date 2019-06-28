import Foundation
import UIKit
import RxCocoa
import RxSwift

class RootViewController: UIViewController {
    @IBOutlet weak var startButton: CustomUIButton!
    @IBOutlet weak var historyButton: CustomUIButton!
    @IBOutlet weak var settingButton: CustomUIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!

    private let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setBackButtonItem()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .background
        userImage.image = User.image
        usernameLabel.text = User.username
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.rx.tap.subscribe({ _ in
            self.navigationController?.loadViewController(identifier: RoomListViewController.className, completion: nil)
        }).disposed(by: disposeBag)
        settingButton.rx.tap.subscribe({ _ in
            self.navigationController?.loadViewController(identifier: HistoryViewController.className, completion: nil)
        }).disposed(by: disposeBag)
    }
}
