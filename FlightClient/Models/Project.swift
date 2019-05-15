import Foundation
import SwiftyJSON

// swiftlint:disable identifier_name
struct Project {
    let id: Int?
    let title: String
}

extension Project: ResponseObjectSerializable {
    static func decodeFrom(json: JSON) -> Project {
        let id = json["id"].int
        let title = json["title"].stringValue

        return Project(id: id, title: title)
    }
}

// swiftlint:enable identifier_name

extension Project: ResponseCollectionSerializable {
    static func decodeFrom(json: JSON) -> [Project] {
        return json.arrayValue.compactMap { Project.decodeFrom(json: $0) }
    }
}

extension Project: Codable {
}
