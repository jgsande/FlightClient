import UIKit
import TermiNetwork

class ViewController: UIViewController {
    var launchCoordinator: LaunchCoordinating!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        launchCoordinator = LaunchCoordinator.assemble()
        TNEnvironment.set(Environment.localhost)

        view.addSubview(launchCoordinator.rootViewController.view)
    }
}
