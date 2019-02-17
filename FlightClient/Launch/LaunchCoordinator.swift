import UIKit

// swiftlint:disable force_cast

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

// swiftlint:enable force_cast
