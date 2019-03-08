import UIKit

enum State {
    case initial
    case pending
    case success
    case error(String)
}

class ViewController: UIViewController {

    var currentState: State = .initial

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

    func setState(nextState: State) {
        // reset the UI
        toggleSpinner(false)
        message.isHidden = true
        loginButton.setTitle("login", for: .normal)
        // ---

        currentState = nextState
        switch nextState {
        case .initial: break
        case .pending:
            toggleSpinner(true)
        case .success:
            show(message: "login success", color: .green)
        case .error(let msg):
            show(message: "ERROR: \(msg)", color: .red)
            loginButton.setTitle("retry", for: .normal)
        }
    }

    func login(username: String, password: String) {
        if case State.pending = currentState {
            // don't allow to submit twice
            return
        }
        setState(nextState: .pending)
        do {
            try submit(username: username, password: password) { result in
                switch result {
                case .ok:
                    self.setState(nextState: .success)
                case .failed(let msg):
                    self.setState(nextState: .error("failed to login: \(msg), please retry"))
                }
            }
        } catch DataError.timeout {
            setState(nextState: .error("timed out, please retry"))
        } catch {
            setState(nextState: .error("unkown error, please retry"))
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

