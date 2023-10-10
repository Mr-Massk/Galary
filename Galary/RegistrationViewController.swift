import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mainScreenView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    // MARK: - lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - IBActions    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if login.isEmpty || password.isEmpty {
            checkingEmptyFields(login, password)
        } else {
            if password.count > 3 {
                savingCredentials(login, password)
            } else {
                showAlert(title: "Error:", message: "The password must be at least four characters")
            }
        }
    }
    
    // MARK: - Flow funcs
    func checkingEmptyFields(_ login: String, _ password: String) {
        if login.isEmpty && password.isEmpty {
            showAlert(title: "Warning:", message: "Login and password fields are empty")
        } else if login.isEmpty {
            showAlert(title: "Warning:", message: "Login field is empty")
        } else {
            showAlert(title: "Warning:", message: "Password field is empty")
        }
    }
    
    func savingCredentials(_ login: String, _ password: String) {
        UserDefaults.standard.set(login, forKey: "login")
        UserDefaults.standard.set(password, forKey: "password")
        showAlert(title: "Success", message: "Data saving completed", goBack: true)
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
