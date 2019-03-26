import Foundation

enum ApiServer: String {
    case prod = "https://flight-gsd.herokuapp.com"
    case dev = "http://localhost:8080"
}

struct ApiConfiguration {
    let baseUrl: String

    init(apiServer: ApiServer = ApiServer.prod) {
        self.baseUrl = apiServer.rawValue
    }
}
