import Foundation
import SwiftyJSON

protocol ApiResult: Decodable {
    static func decodeFrom(json: JSON) -> ApiResult
}

struct EmptyResponse: ApiResult {
    static func decodeFrom(json: JSON) -> ApiResult {
        return EmptyResponse()
    }
}

enum ApiError: Error {
    case errorCode(String)
}
