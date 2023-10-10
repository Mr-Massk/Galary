import UIKit

class ImagePickerViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var mainScreenView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    // MARK: - lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        MainViewSettings.setMainViewParameters(mainViewSettings: mainScreenView, superView: view)
        showPicker()
    }
    
    // MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showFilemanagerButtonPressed(_ sender: UIButton) {
        addImageToArray()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        addImageToArray()
        showPicker()
        self.descriptionTextField.text = ""
    }
    
    // MARK: - flow funcs
    func showPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func addImageToArray() {
        if let mainImage = mainImageView.image {
            if let nameImage = Images.saveImage(image: mainImage) {
                guard let description = descriptionTextField.text else { return }
                let image = Images(name: nameImage, description: description)
                UserDefaults.standard.set(encodable: image, forKey: nameImage)
                GalaryArray.imagesArray.append(nameImage)
            }
        }
    }
}
