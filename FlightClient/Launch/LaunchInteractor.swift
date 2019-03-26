import Foundation
import SwiftyJSON

class LaunchInteractor: LaunchInteracting {
    weak var output: LaunchInteractingOutput?

    private let defaultSession: URLSession
    private var dataTask: URLSessionDataTask?

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 3.0
        defaultSession = URLSession(configuration: configuration)
    }

    func getHelloWorld() {
        guard let url = FlightRouteBuilder.routeUrl(.helloWorld) else { return }

        request(url) { (result: Result<StringWrapper, ApiError>) in
            switch result {
            case .success(let stringWrapper):
                self.output?.didGetHelloWorld(stringWrapper.string)
            case .failure(let error):
                self.output?.didReceiveError(error)
            }
        }
    }

    func getUserInfo() {
        guard let url = FlightRouteBuilder.routeUrl(.user) else { return }

        request(url) { (result: Result<UserInfo, ApiError>) in
            switch result {
            case .success(let userInfo):
                self.output?.didGetUserInfo(userInfo)
            case .failure(let error):
                self.output?.didReceiveError(error)
            }
        }
    }

    private func request<T: ApiResult>(_ url: URL, completion: @escaping (Result<T, ApiError>) -> Void) {
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            defer { self.dataTask = nil }

            // detect JWT expiry date error, retry
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.errorCode(error.localizedDescription)))
                }
            } else if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {

                DispatchQueue.main.async {
                    completion(.failure(ApiError.errorCode("\(response.statusCode)")))
                }
            } else if let data = data {
                var jsonData: JSON
                do {
                    jsonData = try JSON(data: data)
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(ApiError.errorCode(error.localizedDescription)))
                    }

                    return
                }
                DispatchQueue.main.async {
                    completion(.success(T.decodeFrom(json: jsonData)))
                }
            }
        }

        dataTask?.resume()
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
