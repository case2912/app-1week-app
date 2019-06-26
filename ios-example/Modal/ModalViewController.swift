import Foundation
import UIKit
import RxCocoa
import RxSwift

class ModalViewController: UIViewController {
    @IBOutlet weak var backButton: CustomUIButton!
    @IBOutlet weak var submitButton: CustomUIButton!
    private let disposeBag = DisposeBag()
    var roomViewModel: RoomViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.rx.tap.subscribe({ _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        submitButton.rx.tap.subscribe({ _ in
            self.roomViewModel.message.messageType = MessageType.Haiku.rawValue
            self.roomViewModel.message.message = "ここにあるのははいくです"
            self.roomViewModel.sendMessage()
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
