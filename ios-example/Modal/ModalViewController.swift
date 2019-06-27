import Foundation
import UIKit
import RxCocoa
import RxSwift

class ModalViewController: UIViewController {
    @IBOutlet weak var backButton: CustomUIButton!
    @IBOutlet weak var submitButton: CustomUIButton!
    @IBOutlet weak var textField: CTUITextField!
    private let disposeBag = DisposeBag()
    var roomViewModel: RoomViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.rx.text.orEmpty.asObservable().subscribe({ event in
            print("text field changed")
            self.textField.setNeedsDisplay()
        }).disposed(by: disposeBag)
        backButton.rx.tap.subscribe({ _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        submitButton.rx.tap.subscribe({ _ in
            self.roomViewModel.message.messageType = MessageType.Haiku.rawValue
            guard let text = self.textField.text else { return }
            self.roomViewModel.message.message = text
            self.roomViewModel.sendMessage()
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
