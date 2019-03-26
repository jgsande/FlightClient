import Foundation
import SwiftyJSON

public struct UserInfo {
    let firstName: String
    let lastName: String
    let userName: String
}

//extension UserInfo {
//    public init?(json: JSON) {
//        firstName = json["first_name"].stringValue
//        lastName = json["last_name"].stringValue
//        userName = json["user_name"].stringValue
//    }
//}

extension UserInfo: ApiResult {
    static func decodeFrom(json: JSON) -> ApiResult {
        let firstName = json["first_name"].stringValue
        let lastName = json["last_name"].stringValue
        let userName = json["user_name"].stringValue

        return UserInfo(firstName: firstName, lastName: lastName, userName: userName)
    }
}
