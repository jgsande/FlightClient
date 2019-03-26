import Foundation
import SwiftyJSON

protocol ApiResult {
    static func decodeFrom(json: JSON) -> ApiResult
}
