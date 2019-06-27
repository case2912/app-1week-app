import Foundation
import UIKit
import RxCocoa
import RxSwift

class RootViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var historyButton: CustomUIButton!
    private let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setBackButtonItem()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .background
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.rx.tap
            .subscribe({ _ in
                self.navigationController?.loadViewController(identifier: RoomListViewController.className, completion: nil)
            }).disposed(by: disposeBag)
    }
}
