import Foundation
import UIKit
import RxCocoa
import RxSwift

class RootViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var historyButton: CustomUIButton!

    private let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "japanese-paper")!)
        startButton.rx.tap
            .subscribe({ _ in
                guard let roomListViewController = self.storyboard?.instantiateViewController(withIdentifier: "RoomListViewController") else { return }
                self.navigationController?.pushViewController(roomListViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
