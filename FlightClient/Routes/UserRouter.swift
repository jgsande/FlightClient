import TermiNetwork

enum UserRouter: TNRouterProtocol {
    // Define your routes
    case signIn(login: String, password: String)
    case signUp(login: String, password: String)
    case current

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
        case .current:
            let headers = ["x-auth": JWTManager.standard.accessToken()!]
            return TNRouteConfiguration(method: .get,
                                        path: path("v1/account/current"),
                                        params: nil,
                                        headers: headers,
                                        requestConfiguration: configuration)

        }
    }
}
