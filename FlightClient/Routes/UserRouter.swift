import TermiNetwork

enum UserRouter: TNRouterProtocol {
    // Define your routes
    case signIn(login: String, password: String)
    case signUp(login: String, password: String)

    // Set method, path, params, headers for each route
    func configure() -> TNRouteConfiguration {
        let headers = ["x-auth": "abcdef1234"]
        let configuration = TNRequestConfiguration(requestBodyType: .JSON)

        switch self {
        case .signIn(let login, let password):
            let params = ["login": login, "password": password]
            return TNRouteConfiguration(method: .post,
                                        path: path("v1/account/sign-in"),
                                        params: params,
                                        headers: headers,
                                        requestConfiguration: configuration)
        case .signUp(let login, let password):
            let params = ["login": login, "password": password]
            return TNRouteConfiguration(method: .post,
                                        path: path("v1/account/sign-up"),
                                        params: params,
                                        headers: headers,
                                        requestConfiguration: configuration)
        }
    }
}
