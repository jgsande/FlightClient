import Foundation

class LaunchPresenter: LaunchPresenting {
    var interactor: LaunchInteracting!
    weak var view: LaunchViewable!

    func viewDidAppear() {
    }

    func signIn(login: String, password: String) {
        interactor.signIn(login: login, password: password)
    }

    func signUp(login: String, password: String) {
        interactor.signUp(login: login, password: password)
    }

    func getProjects() {
        interactor.getProjects()
    }

    func createProject(title: String) {
        interactor.createProject(title: title)
    }
}

extension LaunchPresenter: LaunchInteractingOutput {
    func didSignIn() {
        view.didSignIn()
    }

    func didSignUp() {
        view.didSignUp()
    }

    func didGetProjects(_ projects: [Project]) {
        view.didGetProjects(projects)
    }

    func didReceiveError(_ error: Error?) {
        view.showErrorMessage(error)
    }

    func didCreateProject(_ project: Project) {
        print(project)
    }
}
