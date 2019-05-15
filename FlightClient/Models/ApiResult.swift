import Foundation
import SwiftyJSON

protocol ResponseObjectSerializable {
    static func decodeFrom(json: JSON) -> Self
}

protocol ResponseCollectionSerializable {
    static func decodeFrom(json: JSON) -> [Self]
}

struct EmptyResponse: ResponseObjectSerializable {
    static func decodeFrom(json: JSON) -> EmptyResponse {
        return EmptyResponse()
    }
}

extension EmptyResponse: Codable {
}

enum ApiError: Error {
    case errorCode(String)
}
