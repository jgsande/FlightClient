import UIKit

protocol LaunchCoordinating: class {
    var rootViewController: UIViewController! { get set }

    static func assemble() -> LaunchCoordinating
}

protocol LaunchViewable: class {
    var coordinator: LaunchCoordinating! { get set }

    func didSignIn()
    func didSignUp()
    func didGetProjects(_ projects: [Project])
    func showErrorMessage(_ error: Error?)
}

protocol LaunchPresenting {
    var interactor: LaunchInteracting! { get set }
    var view: LaunchViewable! { get set }

    func viewDidAppear()
    func signIn(login: String, password: String)
    func signUp(login: String, password: String)
    func createProject(title: String)
    func getProjects()
}

protocol LaunchInteracting {
    var output: LaunchInteractingOutput? { get set }

    func signIn(login: String, password: String)
    func signUp(login: String, password: String)
    func createProject(title: String)
    func getProjects()
}

protocol LaunchInteractingOutput: class {
    func didSignIn()
    func didSignUp()
    func didCreateProject(_ project: Project)
    func didGetProjects(_ projects: [Project])
    func didReceiveError(_ error: Error?)
}
