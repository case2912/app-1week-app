import Foundation

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
