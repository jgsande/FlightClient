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
