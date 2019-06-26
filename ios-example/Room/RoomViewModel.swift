import Foundation
import Starscream

final class RoomViewModel {
    var message = Message(message: "", messageType: MessageType.Comment.rawValue, from: "clientID")
    var socket: WebSocket
    init(_ socket: WebSocket) {
        self.socket = socket
    }
    var messages: [Message] = []
    var renga: [Message] = []
    func connect() {
        socket.connect()
    }
    func disconnect() {
        socket.disconnect()
    }
    func sendMessage() {
        if message.message == "" {
            return
        }
        do {
            let data = try JSONEncoder().encode(message)
            print(data)
            socket.write(data: data)
        } catch let error {
            print(error)
        }
        message.message = ""
    }
}

