import Foundation
import SwiftyJSON

public struct JWTTokens {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}

extension JWTTokens: ApiResult {
    static func decodeFrom(json: JSON) -> ApiResult {
        let accessToken = json["accessToken"].stringValue
        let refreshToken = json["refreshToken"].stringValue
        let expiredAt = json["expiredAt"].stringValue

        return JWTTokens(accessToken: accessToken, refreshToken: refreshToken, expiredAt: expiredAt)
    }
}
