//
//  ViewController.swift
//  FlightClient
//
//  Created by Jose Garcia on 12/02/2019.
//  Copyright © 2019 Jose Garcia. All rights reserved.
//

import UIKit
import FLModel

class ViewController: UIViewController {
    var launchCoordinator: LaunchCoordinating!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        launchCoordinator = LaunchCoordinator.assemble()

        view.addSubview(launchCoordinator.rootViewController.view)
    }
}
