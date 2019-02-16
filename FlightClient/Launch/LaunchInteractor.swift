//
//  LaunchInteractor.swift
//  FlightClient
//
//  Created by Jose Garcia on 12/02/2019.
//  Copyright © 2019 Jose Garcia. All rights reserved.
//

import Foundation
import FLModel
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
        guard let url = URL(string: "https://localhost.com:8080/hello") else { return }
        
        get(url: url) { data ,error in
            guard let data = data else {
                self.output?.didReceiveError(error!)
                return
            }

            let string = String(bytes: data, encoding: .utf8)

        }
    }

    func getUserInfo() {
        guard let url = URL(string: "https://localhost.com:8080/user") else { return }
        
        get(url: url) { data ,error in
            guard let data = data else {
                self.output?.didReceiveError(error!)
                return
            }

            do {
                let json = try JSON(data: data)
                guard let userInfo = UserInfo(json: json) else { return }

                self.output?.didGetUserInfo(userInfo)
            } catch {
                self.output?.didReceiveError(error)
            }
        }
    }
    
    private func get(url: URL, completion: @escaping (Data?, Error?)->Void ) {
        
        dataTask?.cancel()

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            defer { self.dataTask = nil }
        
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {

                DispatchQueue.main.async {
                    completion(nil, nil)
                }
            } else if let data = data {
                completion(data, nil)
            }
        }

        dataTask?.resume()
    }
}
