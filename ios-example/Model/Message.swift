import Foundation

enum MessageType: String {
    case Comment = "Comment"
    case Haiku = "Haiku"
    case Unknown = "Unknown"
}

struct Message: Codable {
    var message: String
    var messageType: String
    var from :String
}
