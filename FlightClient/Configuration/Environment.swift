import TermiNetwork

enum Environment: TNEnvironmentProtocol {
    case localhost
    case dev
    case production

    func configure() -> TNEnvironment {
        let requestConfiguration = TNRequestConfiguration(cachePolicy: .useProtocolCachePolicy,
                                                          timeoutInterval: 30,
                                                          requestBodyType: .JSON)
        switch self {
        case .localhost:
            return TNEnvironment(scheme: .http,
                                 host: "localhost",
                                 port: 8080,
                                 requestConfiguration: requestConfiguration)
        case .dev:
            return TNEnvironment(scheme: .https,
                                 host: "mydevserver.com",
                                 suffix: path("v1"),
                                 requestConfiguration: requestConfiguration)
        case .production:
            return TNEnvironment(scheme: .https,
                                 host: "https://flight-gsd.herokuapp.com",
                                 suffix: path("v1"),
                                 requestConfiguration: requestConfiguration)
        }
    }
}
