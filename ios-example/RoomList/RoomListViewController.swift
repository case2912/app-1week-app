import UIKit
import RxSwift
import RxCocoa
class RoomListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    private let viewModel = RoomListViewModel()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setBackButtonItem()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        tableView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2)
        tableView.register(UINib(nibName: CustomTableViewCell.className, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.className)
        tableView.refreshControl = refreshControl
        fetchRoomList()
        button.rx.tap.subscribe({ _ in
            self.viewModel.createRoom { roomId in
                self.navigationController?.loadViewController(identifier: RoomViewController.className) { (controller: UIViewController) -> Void in
                    (controller as! RoomViewController).roomID = roomId
                }
            }
        }).disposed(by: disposeBag)
        refreshControl.rx.controlEvent(.valueChanged).subscribe({ _ in
            self.fetchRoomList()
        }).disposed(by: disposeBag)

    }
    func fetchRoomList() {
        self.viewModel.fetchRoomList {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

extension RoomListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.className, for: indexPath) as! CustomTableViewCell
        cell.roomInfo = viewModel.rooms[indexPath.row]
        cell.parentViewController = self
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

