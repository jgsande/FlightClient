//
//  LaunchPresenter.swift
//  FlightClient
//
//  Created by Jose Garcia on 12/02/2019.
//  Copyright © 2019 Jose Garcia. All rights reserved.
//

import Foundation
import FLModel

class LaunchPresenter: LaunchPresenting {
    var interactor: LaunchInteracting!
    weak var view: LaunchViewable!

    func viewDidAppear() {
        interactor.getUserInfo()
    }
}

extension LaunchPresenter: LaunchInteractingOutput {
    func didGetUserInfo(_ userInfo: UserInfo) {
        view.showUserInfo(userInfo)
    }

    func didReceiveError(_ error: Error) {
        
    }
}
