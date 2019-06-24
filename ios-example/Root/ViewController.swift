import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.refreshControl = refreshControl
        button.rx.tap
            .subscribe({ _ in
                print("tapped!")
            }).disposed(by: disposeBag)
        refreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe({ _ in
                print("refresh!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.refreshControl.endRefreshing()
                }
            }).disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
        tableView.backgroundColor = .clear
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = .clear
        return sectionView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let roomViewController = self.storyboard!.instantiateViewController(withIdentifier: "RoomViewController")
        navigationController?.pushViewController(roomViewController, animated: true)
    }
}

