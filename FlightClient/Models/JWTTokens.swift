import Foundation
import SwiftyJSON

public struct JWTTokens {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
}

extension JWTTokens: Codable { }
