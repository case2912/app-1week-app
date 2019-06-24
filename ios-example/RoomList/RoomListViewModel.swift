import Foundation

struct RoomListResponse: Codable {
    var rooms: [String]
}
struct RoomCreateResponse: Codable {
    var room_id: String
}
final class RoomListViewModel {
    private(set) var rooms: [String] = []
    func createRoom(_ completion: ((_ roomID: String) -> ())?) {
        guard let url = URL(string: "http://127.0.0.1:8080/room/create")else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {
                return
            }
            guard let json = try? JSONDecoder().decode(RoomCreateResponse.self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                completion?(json.room_id)
                print("present room view controller")
                print(json)
            }
        }.resume()
    }
    func fetchRoomList(_ completion: (() -> ())?) {
        guard let url = URL(string: "http://127.0.0.1:8080/roomlist")else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {
                return
            }
            guard let json = try? JSONDecoder().decode(RoomListResponse.self, from: data) else {
                return
            }
            self.rooms.removeAll()
            self.rooms += json.rooms
            DispatchQueue.main.async {
                print("reload table")
                completion?()
            }
        }.resume()
    }
}
