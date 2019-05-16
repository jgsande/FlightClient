import Foundation
import SwiftyJSON

public struct UserInfo {
    let firstName: String
    let lastName: String
    let userName: String
}

extension UserInfo: Codable {
}
