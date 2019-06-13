import UIKit

class LaunchViewController: UIViewController {
    var presenter: LaunchPresenting!
    weak var coordinator: LaunchCoordinating!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    @IBAction func didPressButton(_ sender: UIButton) {
        guard let login = loginTextField.text,
            let password = passwordTextField.text else {
                return
        }

        presenter.signIn(login: login, password: password)
    }
}

extension LaunchViewController: LaunchViewable {
    func didSignIn() {
        print("didSignIn")
        presenter.getProjects()
    }

    func didSignUp() {
        print("didSignUp")
    }

    func showUserInfo(_ userInfo: UserInfo) {
        print(userInfo)
    }

    func showErrorMessage(_ error: Error?) {
        print(error?.localizedDescription ?? "Oops")
    }

    func didGetProjects(_ projects: [Project]) {
        print(projects)
    }
}
