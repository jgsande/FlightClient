import UIKit
import FLModel

class LaunchViewController: UIViewController {
    var presenter: LaunchPresenting!
    weak var coordinator: LaunchCoordinating!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    @IBAction func didPressButton(_ sender: UIButton) {
        presenter.viewDidAppear()
    }
}

extension LaunchViewController: LaunchViewable {
    func showUserInfo(_ userInfo: UserInfo) {
        print(userInfo)
    }
    
    func showErrorMessage(_ error: Error) {
        print(error.localizedDescription)
    }
}
