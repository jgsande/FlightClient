import Foundation
import SwiftyJSON

// swiftlint:disable identifier_name
struct Project {
    let id: Int?
    let title: String
}

extension Project: Codable { }

// swiftlint:enable identifier_name
