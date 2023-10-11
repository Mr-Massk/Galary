import Foundation
import UIKit

extension GalaryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    func hideKeyboard() {
        view.endEditing(true)
    }
}
