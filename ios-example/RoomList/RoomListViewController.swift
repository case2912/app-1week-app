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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "japanese-paper")!)
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.refreshControl = refreshControl

        button.rx.tap
            .subscribe({ _ in
                print("tapped!")
                self.viewModel.createRoom { id in
                    print(id)
                    guard let roomViewController = self.storyboard?.instantiateViewController(withIdentifier: "RoomViewController") as? RoomViewController else { return }
                    roomViewController.roomID = id
                    self.navigationController?.pushViewController(roomViewController, animated: true)
                }
            }).disposed(by: disposeBag)
        refreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe({ _ in
                print("refresh!")
                self.viewModel.fetchRoomList {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }).disposed(by: disposeBag)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.rooms[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let roomViewController = self.storyboard!.instantiateViewController(withIdentifier: "RoomViewController") as? RoomViewController else {
            return
        }
        roomViewController.roomID = viewModel.rooms[indexPath.row]
        navigationController?.pushViewController(roomViewController, animated: true)
    }
}

