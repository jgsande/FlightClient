import Foundation

enum FlightRoute {
    case helloWorld
    case user
    case signIn
    case signUp
}

enum MyError: Error {
    case routeNotFound(String)
}

struct FlightRouteBuilder {
    private static var api: ApiConfiguration = ApiConfiguration()

    static func updateApi(api: ApiConfiguration) {
        self.api = api
    }

    static func routeUrl(_ route: FlightRoute) -> String {
        switch route {
        case .helloWorld:
            return "\(api.baseUrl)/hello"
        case .user:
            return "\(api.baseUrl)/user"
        case .signIn:
            return "\(api.baseUrl)/v1/account/sign-in"
        case .signUp:
            return "\(api.baseUrl)/v1/account/sign-up"
        }
    }
}
