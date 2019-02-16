//
//  LaunchContract.swift
//  FlightClient
//
//  Created by Jose Garcia on 12/02/2019.
//  Copyright © 2019 Jose Garcia. All rights reserved.
//

import Foundation
import FLModel

protocol LaunchCoordinating: class {
    var rootViewController: UIViewController! { get set }

    static func assemble() -> LaunchCoordinating
}

protocol LaunchViewable: class {
    var coordinator: LaunchCoordinating! { get set }

    func showUserInfo(_ userInfo: UserInfo)
    func showErrorMessage(_ error: Error)
}

protocol LaunchPresenting {
    var interactor: LaunchInteracting! { get set }
    var view: LaunchViewable! { get set }

    func viewDidAppear()
}

protocol LaunchInteracting {
    var output: LaunchInteractingOutput? { get set }

    func getHelloWorld()
    func getUserInfo()
}

protocol LaunchInteractingOutput: class {
    func didGetUserInfo(_ userInfo: UserInfo)
    func didReceiveError(_ error: Error)
}
