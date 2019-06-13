import TermiNetwork

enum UserRouter: TNRouterProtocol {
    // Define your routes
    case signIn(login: String, password: String)
    case signUp(login: String, password: String)
    case refreshToken

    // Set method, path, params, headers for each route
    func configure() -> TNRouteConfiguration {
        let configuration = TNRequestConfiguration(requestBodyType: .JSON)

        switch self {
        case .signIn(let login, let password):
            let params = ["login": login, "password": password]
            return TNRouteConfiguration(method: .post,
                                        path: path("v1/account/sign-in"),
                                        params: params,
                                        headers: nil,
                                        requestConfiguration: configuration)
        case .signUp(let login, let password):
            let params = ["login": login, "password": password]
            return TNRouteConfiguration(method: .post,
                                        path: path("v1/account/sign-up"),
                                        params: params,
                                        headers: nil,
                                        requestConfiguration: configuration)
        case .refreshToken:
            let params = ["refreshToken": JWTManager.standard.refreshToken()!]
            return TNRouteConfiguration(method: .post,
                                        path: path("v1/account/refresh-token"),
                                        params: params,
                                        headers: nil,
                                        requestConfiguration: configuration)

        }
    }
}
