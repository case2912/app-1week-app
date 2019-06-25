import Foundation
import UIKit
import RxCocoa
import RxSwift

class RootViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startButton: UIButton!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        label.text = UIDevice.current.identifierForVendor?.uuidString
        view.backgroundColor = UIColor(patternImage: UIImage(named: "japanese-paper")!)
        startButton.rx.tap
            .subscribe({ _ in
                guard let roomListViewController = self.storyboard?.instantiateViewController(withIdentifier: "RoomListViewController") else { return }
                self.navigationController?.pushViewController(roomListViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
