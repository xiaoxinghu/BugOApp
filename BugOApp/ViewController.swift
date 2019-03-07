import UIKit

class ViewController: UIViewController {


    var spinner = UIAlertController(title: nil, message: "Logging in...", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        spinner.view.addSubview(loadingIndicator)
    }

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            fatalError()
        }
        login(username: username, password: password)
    }

    func login(username: String, password: String) {
        toggleSpinner(true)
        do {
            try submit(username: username, password: password) { result in
                self.toggleSpinner(false)
                switch result {
                case .ok:
                    self.show(message: "login success", color: .green)
                case .failed(let msg):
                    self.show(message: "failed to login: \(msg), please retry", color: .orange)
                    self.loginButton.setTitle("retry", for: .normal)
                }
            }
        } catch DataError.timeout {
            show(message: "timed out, please retry", color: .red)
            loginButton.setTitle("retry", for: .normal)
        } catch {
            show(message: "unkown error, please retry", color: .red)
            loginButton.setTitle("retry", for: .normal)
        }
    }

    func show(message: String, color: UIColor) {
        self.message.isHidden = false
        self.message.textColor = color
        self.message.text = message
    }

    func toggleSpinner(_ on: Bool) {
        if on {
            present(spinner, animated: true, completion: nil)
        } else {
            spinner.dismiss(animated: false, completion: nil)
        }
    }
}

