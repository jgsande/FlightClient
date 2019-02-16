//
//  LaunchCoordinator.swift
//  FlightClient
//
//  Created by Jose Garcia on 12/02/2019.
//  Copyright © 2019 Jose Garcia. All rights reserved.
//

import UIKit

class LaunchCoordinator: LaunchCoordinating {
    var rootViewController: UIViewController!

    static func assemble() -> LaunchCoordinating {
        let coordinator = LaunchCoordinator()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        let presenter = LaunchPresenter()
        let interactor = LaunchInteractor()
        
        coordinator.rootViewController = view
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        return coordinator
    }
}
