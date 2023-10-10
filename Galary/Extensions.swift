import UIKit
import Foundation

extension UIView {
    func dropShadow() {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.7
            layer.shadowOffset = CGSize(width: 5, height: 5)
            layer.shadowRadius = 5
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, goBack: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            if goBack {
                self.navigationController?.popViewController(animated: true)
            }
        }        
        alert.addAction(ok)
        present(alert , animated: true)
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage = UIImage()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        self.mainImageView.image = chosenImage
        picker.dismiss(animated: true)
    }
}

extension UserDefaults {

    func set<T: Encodable>(encodable: T, forKey key: String)  {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }

    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    
}


