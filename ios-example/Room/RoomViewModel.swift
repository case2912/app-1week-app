import Foundation
import Starscream
final class RoomViewModel {
    var message: String?
    var socket: WebSocket
    init(_ socket: WebSocket) {
        self.socket = socket
    }
    var messages: [Messsage] = []
    func connect() {
        socket.connect()
    }
    func disconnect() {
        socket.disconnect()
    }
    func sendMessage() {
        do {
            let data = try JSONSerialization.data(
                withJSONObject: ["message": self.message],
                options: []
            )
            socket.write(data: data)
        } catch let error {
            print(error)
        }
    }
}

