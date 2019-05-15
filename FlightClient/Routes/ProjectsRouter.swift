import TermiNetwork

enum ProjectsRouter: TNRouterProtocol {
    // Define your routes
    case getProjects
    case createProject(title: String)

    // Set method, path, params, headers for each route
    func configure() -> TNRouteConfiguration {
        let configuration = TNRequestConfiguration(requestBodyType: .JSON)

        switch self {
        case .getProjects:
            let headers = ["Authorization": JWTManager.standard.accessToken()!]
            return TNRouteConfiguration(method: .get,
                                        path: path("v1/project"),
                                        params: nil,
                                        headers: headers,
                                        requestConfiguration: configuration)
        case .createProject(let title):
            let params = ["title": title]
            let headers = ["Authorization": JWTManager.standard.accessToken()!]
            return TNRouteConfiguration(method: .post,
                                        path: path("v1/project"),
                                        params: params,
                                        headers: headers,
                                        requestConfiguration: configuration)
        }
    }
}
