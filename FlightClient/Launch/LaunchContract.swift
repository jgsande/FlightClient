import UIKit

protocol LaunchCoordinating: class {
    var rootViewController: UIViewController! { get set }

    static func assemble() -> LaunchCoordinating
}

protocol LaunchViewable: class {
    var coordinator: LaunchCoordinating! { get set }

    func didSignIn()
    func didSignUp()
    func showErrorMessage(_ error: Error?)
}

protocol LaunchPresenting {
    var interactor: LaunchInteracting! { get set }
    var view: LaunchViewable! { get set }

    func viewDidAppear()
    func signIn(login: String, password: String)
}

protocol LaunchInteracting {
    var output: LaunchInteractingOutput? { get set }

    func signIn(login: String, password: String)
    func getUserInfo()
}

protocol LaunchInteractingOutput: class {
    func didGetUserInfo(_ userInfo: UserInfo)
    func didSignIn()
    func didSignUp()
    func didReceiveError(_ error: Error?)
}
