import Foundation
import SwiftyJSON

struct EmptyResponse {
}

extension EmptyResponse: Codable {
}

enum ApiError: Error {
    case errorCode(String)
}
