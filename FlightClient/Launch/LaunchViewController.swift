import UIKit

class LaunchViewController: UIViewController {
    var presenter: LaunchPresenting!
    weak var coordinator: LaunchCoordinating!
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            self.loginTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.delegate = self
        }
    }

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
}

extension LaunchViewController: UITextFieldDelegate {

}
