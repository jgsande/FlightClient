import Foundation
import SwiftyJSON

public struct JWTTokens {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}

extension JWTTokens: ResponseObjectSerializable {
    static func decodeFrom(json: JSON) -> JWTTokens {
        let accessToken = json["accessToken"].stringValue
        let refreshToken = json["refreshToken"].stringValue
        let expiredAt = json["expiredAt"].stringValue

        return JWTTokens(accessToken: accessToken, refreshToken: refreshToken, expiredAt: expiredAt)
    }
}

extension JWTTokens: Codable {
}
