import Foundation
import UIKit

class Credentials: UIViewController {
    static func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
//        present(alert , animated: true)
    }
}
