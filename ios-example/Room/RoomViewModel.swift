import Foundation
import Starscream

final class RoomViewModel {
    var message :Message?
    var socket: WebSocket
    var messages: [Message] = []
    var renga: [Message] = []

    init(_ socket: WebSocket) {
        self.socket = socket
    }
    func connect() {
        socket.connect()
    }
    func disconnect() {
        socket.disconnect()
    }
    func sendMessage() {
        if message == nil || message?.message == "" {
            return
        }
        do {
            let data = try JSONEncoder().encode(message)
            socket.write(data: data)
        } catch let error {
            print(error)
        }
        resetMessage()
    }
    func resetMessage() {
        message = nil
    }
}

