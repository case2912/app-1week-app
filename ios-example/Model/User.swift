import Foundation
import UIKit
struct UserResponse: Codable {
    let results: [Result]
    struct Login: Codable {
        let username: String
    }
    struct Picture: Codable {
        let thumbnail: String
    }
    struct Result: Codable {
        var login: Login
        var picture: Picture
    }

}
struct User {
    static var image: UIImage?
    static var username: String?
    static var imageString: String?
    static func uuid() -> String {
        if let uuid = UserDefaults.standard.object(forKey: UserDefaults.clientUUIDString) as? String {
            return uuid
        } else {
            return ""
        }
    }

    static func user(completion: (() -> Void)?) {
        guard let url = URL(string: "https://randomuser.me/api/?seed=\(uuid())")else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do {
                let json = try JSONDecoder().decode(UserResponse.self, from: data)
                username = json.results[0].login.username
                let data = try Data(contentsOf: URL(string: json.results[0].picture.thumbnail)!)
                image = UIImage(data: data)
                imageString = json.results[0].picture.thumbnail
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                completion?()
            }
        }.resume()
    }
}
