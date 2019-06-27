import UIKit
import RxCocoa
import RxSwift
class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var button: CustomUIButton!
    var roomInfo: String!
    var parentViewController: UIViewController!
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        button.rx.tap.subscribe({ _ in
            guard let roomViewController = self.parentViewController.storyboard!.instantiateViewController(withIdentifier: RoomViewController.className) as? RoomViewController else {
                return
            }
            roomViewController.roomID = self.roomInfo
            self.parentViewController.navigationController?.pushViewController(roomViewController, animated: true)
        }).disposed(by: disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
