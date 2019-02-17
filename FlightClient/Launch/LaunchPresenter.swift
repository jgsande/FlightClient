import Foundation
import FLModel

class LaunchPresenter: LaunchPresenting {
    var interactor: LaunchInteracting!
    weak var view: LaunchViewable!

    func viewDidAppear() {
        interactor.getUserInfo()
    }

    func getHelloWorld() {
        interactor.getHelloWorld()
    }
}

extension LaunchPresenter: LaunchInteractingOutput {
    func didGetUserInfo(_ userInfo: UserInfo) {
        view.showUserInfo(userInfo)
    }

    func didGetHelloWorld(_ string: String) {
        view.showHelloWorld(string)
    }

    func didReceiveError(_ error: Error) {
        view.showErrorMessage(error)
    }
}
