import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createNewAccountButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var mainScreenView: UIView!
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        MainViewSettings.setMainViewParameters(mainViewSettings: mainScreenView, superView: self.view)
        textFiedsSettings()
    }
    
    // MARK: - IBActions
    @IBAction func createNewAccountButton(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if login.isEmpty || password.isEmpty {
            checkingEmptyFields(login, password)
        } else {
            credentialVerification(login, password)
        }
    }
    
    
    // MARK: - flow funcs
    func textFiedsSettings() {
        self.passwordTextField.isSecureTextEntry = true
    }
    
    func checkingEmptyFields(_ login: String, _ password: String) {
        if login.isEmpty && password.isEmpty {
            showAlert(title: "Warning:", message: "Login and password fields are empty")
        } else if login.isEmpty {
            showAlert(title: "Warning:", message: "Login field is empty")
        } else {
            showAlert(title: "Warning:", message: "Password field is empty")
        }
    }
    
    func credentialVerification(_ login: String, _ password: String) {
        guard let savedLogin = UserDefaults.standard.value(forKey: "login") as? String else {
            showAlert(title: "Error:", message: "User is not found...")
            return
        }
        if login != savedLogin{
            showAlert(title: "Error:", message: "User is not found...")
        }
        guard let savedPassword = UserDefaults.standard.value(forKey: "password") as? String else {
            showAlert(title: "Error:", message: "Incorrect password")
            return
        }
        if password != savedPassword {
            showAlert(title: "Error:", message: "Incorrect password")
        }
        if login == savedLogin && password == savedPassword {            
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "FileManagerViewController") as? FileManagerViewController else { return } 
            navigationController?.pushViewController(controller, animated: true)
        }
    }  
}
