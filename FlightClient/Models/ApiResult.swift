import Foundation
import SwiftyJSON

protocol ApiResult: Decodable {
    static func decodeFrom(json: JSON) -> ApiResult
}
