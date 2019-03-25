import Foundation

enum FlightRoute {
    case helloWorld
    case user
}

enum MyError: Error {
    case routeNotFound(String)
}

struct FlightRouteBuilder {
    private static var api: ApiConfiguration = ApiConfiguration()

    static func updateApi(api: ApiConfiguration) {
        self.api = api
    }

    static func routeUrl(_ route: FlightRoute) -> URL? {
        switch route {
        case .helloWorld:
            return URL(string: "\(api.baseUrl)/hello")
        case .user:
            return URL(string: "\(api.baseUrl)/user")
        }
    }
}
