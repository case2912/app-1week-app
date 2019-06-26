import Foundation
import UIKit
import RxSwift
import RxCocoa
import Starscream
class RoomViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    @IBOutlet weak var myButton: UIButton!


    var roomID: String?
    private var viewModel: RoomViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        view.backgroundColor = UIColor(patternImage: UIImage(named: "japanese-paper")!)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        guard let url = URL(string: "ws://127.0.0.1:8080/room?id=\(roomID!)") else {
            return
        }
        let socket = WebSocket(url: url)
        socket.delegate = self
        viewModel = RoomViewModel(socket)
        viewModel.connect()
        tableView.backgroundColor = .clear

        submitButton.rx.tap.subscribe({ _ in
            print("submit")
            self.viewModel.sendMessage()
            self.textField.text = ""
            self.viewModel.message = ""
        }).disposed(by: disposeBag)
        textField.rx.text.orEmpty.asObservable().subscribe({ event in
            print("text field changed")
            guard let message = event.element else { return }
            self.viewModel.message = message
        }).disposed(by: disposeBag)
        myButton.rx.tap.subscribe({ _ in
            print("tap my button")
            guard let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "ModalViewController") else { return }
            self.present(modalViewController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.disconnect()
    }
    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let keyboardFrame = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        UIStackView.animate(withDuration: duration, animations: {

            let transform = CGAffineTransform(translationX: 0, y: -(keyboardFrame.size.height) + self.view.safeAreaInsets.bottom)
            self.stackView.transform = transform
        }, completion: nil)
        print("keyboard show")
    }
    @objc func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }

        UIStackView.animate(withDuration: duration, animations: {
            let transform = CGAffineTransform (translationX: 0, y: 0)
            self.stackView.transform = transform
        }, completion: nil)
        print("keyboard hide")
    }
}

extension RoomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        return cell
    }
}

extension RoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width / 8, height: collectionView.frame.height)
    }
}

extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = (viewModel.messages[indexPath.row] as Messsage).message
        guard let image = cell.imageView else { return cell }
        image.clipsToBounds = true
        image.layer.cornerRadius = image.frame.height / 2
        return cell
    }
}
extension RoomViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension RoomViewController: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("didConnect")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("didDisconnect")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("didReceiveMessage")
        guard let data = text.data(using: .utf8)else { return }
        guard let json = try? JSONDecoder().decode(Messsage.self, from: data) else { return }
        viewModel.messages += [json]
        print(viewModel.messages)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: viewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("didReceiveData")
    }
}
