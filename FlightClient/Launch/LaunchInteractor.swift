import Foundation
import SwiftyJSON
import TermiNetwork

class LaunchInteractor: LaunchInteracting {
    weak var output: LaunchInteractingOutput?

    private let defaultSession: URLSession
    private var dataTask: URLSessionDataTask?

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 3.0
        defaultSession = URLSession(configuration: configuration)
    }

    func signIn(login: String, password: String) {
        let params = ["login": login, "password": password]

        post(url: FlightRouteBuilder.routeUrl(.signIn),
             headers: nil,
             params: params) { [weak self] (result: Result<JWTTokens, ApiError>) in
                guard let self = self else { return }

                 switch result {
                 case .success(let jwtTokens):
                    self.persist(jwtTokens: jwtTokens)
                    self.output?.didSignIn()
                 case .failure(let error):
                     self.output?.didReceiveError(error)
                 }
        }
    }

    private enum JWTTokenConstants: String {
        case accessToken
        case refreshToken
        case expiredAt
    }

    private func persist(jwtTokens: JWTTokens) {
        UserDefaults.standard.set(jwtTokens.accessToken, forKey: JWTTokenConstants.accessToken.rawValue)
        UserDefaults.standard.set(jwtTokens.refreshToken, forKey: JWTTokenConstants.refreshToken.rawValue)
        UserDefaults.standard.set(jwtTokens.expiredAt, forKey: JWTTokenConstants.expiredAt.rawValue)
    }

    func signUp(login: String, password: String) {
        let params = ["login": login, "password": password]

        post(url: FlightRouteBuilder.routeUrl(.signUp),
             headers: nil,
             params: params) { (result: Result<JWTTokens, ApiError>) in
                switch result {
                case .success:
                    self.output?.didSignUp()
                case .failure(let error):
                    self.output?.didReceiveError(error)
                }
        }
    }

    func getUserInfo() {
        get(url: FlightRouteBuilder.routeUrl(.user),
            headers: nil,
            params: nil) { (result: Result<UserInfo, ApiError>) in
                switch result {
                case .success(let userInfo):
                    self.output?.didGetUserInfo(userInfo)
                case .failure(let error):
                    self.output?.didReceiveError(error)
                }
        }
    }

    private func get<T: ApiResult>(url: String,
                                   headers: [String: String]?,
                                   params: [String: String]?,
                                   completion: @escaping (Result<T, ApiError>) -> Void) {
        request(url: url, method: .get, headers: headers, params: params, completion: completion)
    }

    private func post<T: ApiResult>(url: String,
                                    headers: [String: String]?,
                                    params: [String: String]?,
                                    completion: @escaping (Result<T, ApiError>) -> Void) {
        request(url: url, method: .post, headers: headers, params: params, completion: completion)
    }

    private func request<T: ApiResult>(url: String,
                                       method: TNMethod,
                                       headers: [String: String]?,
                                       params: [String: String]?,
                                       completion: @escaping (Result<T, ApiError>) -> Void) {
        let request = TNRequest(method: method, url: url, headers: headers, params: params)
        request.start(responseType: T.self,
                      onSuccess: { (json) in
                        completion(.success(json))
        },
                      onFailure: { (error, _) in
                        print(error)
                        completion(.failure(ApiError.errorCode(error.localizedDescription)))
        })
    }
}

enum ApiError: Error {
    case errorCode(String)
}

struct StringWrapper {
    let string: String
}

extension StringWrapper: ApiResult {
    static func decodeFrom(json: JSON) -> ApiResult {
        return StringWrapper(string: json.stringValue)
    }
}
