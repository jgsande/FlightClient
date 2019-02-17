import UIKit
import FLModel

class LaunchViewController: UIViewController {
    var presenter: LaunchPresenting!
    weak var coordinator: LaunchCoordinating!
    @IBOutlet weak var label: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    @IBAction func didPressButton(_ sender: UIButton) {
        presenter.getHelloWorld()
    }
}

extension LaunchViewController: LaunchViewable {
    func showUserInfo(_ userInfo: UserInfo) {
        print(userInfo)
    }

    func showErrorMessage(_ error: Error) {
        print(error.localizedDescription)
    }

    func showHelloWorld(_ string: String) {
        label.textColor = UIColor(red: CGFloat.random(in: 0 ..< 255)/255.0,
                                  green: CGFloat.random(in: 0 ..< 255)/255.0,
                                  blue: CGFloat.random(in: 0 ..< 255)/255.0,
                                  alpha: 1)
        label.text = string
    }
}
