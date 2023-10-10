import UIKit

class FileManagerViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var imageViewerButton: UIButton!
    @IBOutlet weak var firstContentView: UIView!
    @IBOutlet weak var loginScreenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GalaryArray.loadArray()
        GalaryArray.creatingArrayObjects()
    }
    
    // MARK: - IBActions
    @IBAction func showLoginScreenButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func showImageViewerButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "GalaryViewController") as? GalaryViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func showPickerButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImagePickerViewController") as? ImagePickerViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
