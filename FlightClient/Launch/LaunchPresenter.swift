import Foundation

class LaunchPresenter: LaunchPresenting {
    var interactor: LaunchInteracting!
    weak var view: LaunchViewable!

    func viewDidAppear() {
        interactor.getUserInfo()
    }

    func signIn(login: String, password: String) {
        interactor.signIn(login: login, password: password)
    }
}

extension LaunchPresenter: LaunchInteractingOutput {
    func didSignIn() {
        view.didSignIn()
    }

    func didSignUp() {
        view.didSignUp()
    }

    func didGetUserInfo(_ userInfo: UserInfo) {
        //
    }

    func didReceiveError(_ error: Error?) {
        view.showErrorMessage(error)
    }
}
