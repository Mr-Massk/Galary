import UIKit
class GalaryViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bottomConstraitScrollView: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - let/var
    var mainViewImage = UIImageView()
    var hiddenViewImage = UIImageView()
    var indexElementToArray = 0
    var isNextImageButtonPressed = true
    lazy var screenHeight = UIScreen.main.bounds.height
    lazy var screenWidth = UIScreen.main.bounds.width
    
    // MARK: - lifecicle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        GalaryArray.loadArray()
        settingsFirstViewImage()
        leftButton.dropShadow()
        rightButton.dropShadow()
        self.mainView.addSubview(hiddenViewImage)
        self.mainView.bringSubviewToFront(likeButton)
        registerForKeyboardNotifications()
    }
    
    // MARK: - IBActions
    @IBAction func rightAppearanceImageButtonPressed(_ sender: UIButton) {
        changeDescriptionText()
        showNextImage()
        showDescriptionText()
        checkLikeButtonPressed()
    }
    
    @IBAction func leftApperanceImageButtonPressed(_ sender: UIButton) {
        changeDescriptionText()
        showPreviousImage()
        showDescriptionText()
        checkLikeButtonPressed()
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        onOffLikeButton()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - flow funcs
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomConstraitScrollView.constant = 0
        } else {
            bottomConstraitScrollView.constant = keyboardScreenEndFrame.height + 10
        }
        
        view.needsUpdateConstraints()
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func settingsFirstViewImage() {
        //        mainViewImage.frame = CGRect(x: 0, y: /*screenHeight * 0.13*/ 100, width: /*screenWidth*/200, height: /*screenHeight * 0.67*/400)
        mainViewImage.clipsToBounds = true
        mainViewImage.contentMode = .scaleAspectFill
        assignImage(viewImage: mainViewImage)
        self.mainView.addSubview(mainViewImage)
        settingsConstraintsMainViewImage()
        showDescriptionText()
        checkLikeButtonPressed()
        let x = self.mainViewImage.frame.origin.x
        let y = self.screenWidth
    }
    
    func settingsConstraintsMainViewImage() {
        mainViewImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainViewImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 0),
            mainViewImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: 0),
            mainViewImage.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor,constant: 60),
            mainViewImage.bottomAnchor.constraint(equalTo: mainTextField.safeAreaLayoutGuide.topAnchor ,constant: -10)
        ])
    }
    
    func settingsPositionHiddenImageView(main: UIImageView, hidden: UIImageView) {
        if isNextImageButtonPressed {
            hidden.frame = CGRect(x: screenWidth , y: main.frame.origin.y, width: main.frame.width, height: main.frame.height)
            self.mainView.bringSubviewToFront(hidden)
            self.mainView.bringSubviewToFront(likeButton)
        } else {
            hidden.frame = main.frame
            self.mainView.sendSubviewToBack(hidden)
        }
        hidden.contentMode = .scaleAspectFill
        hidden.clipsToBounds = true
    }
    
    func assignImage(viewImage: UIImageView) {
        let nameImage = GalaryArray.imagesArray[indexElementToArray]
        if let image = Images.loadImage(fileName: nameImage) {
            viewImage.image = image
        } else if let image = UIImage(named: nameImage) {
            viewImage.image = image
        } else {
            showAlert(title: "Error", message: "No images in gallery")
            return
        }
    }
    
    func showNextImage() {
        isNextImageButtonPressed = true
        numberNextImage()
        assignImage(viewImage: self.hiddenViewImage)
        settingsPositionHiddenImageView(main: self.mainViewImage, hidden: self.hiddenViewImage)
        UIView.animate(withDuration: 0.3) {
            self.hiddenViewImage.frame = self.mainViewImage.frame
        }
        func numberNextImage() {
            let quantityImages = GalaryArray.imagesArray.count
            if self.indexElementToArray < quantityImages - 1 {
                self.indexElementToArray += 1
            } else {
                self.indexElementToArray = 0
            }
        }
        changePriorityShowImageView()
    }
    
    func showPreviousImage() {
        isNextImageButtonPressed = false
        numberPreviousImage()
        assignImage(viewImage: self.hiddenViewImage)
        settingsPositionHiddenImageView(main: self.mainViewImage, hidden: self.hiddenViewImage)
        UIView.animate(withDuration: 0.3) {
            self.mainViewImage.frame.origin.x -= self.screenWidth
        }
        
        func numberPreviousImage() {
            let quantityImages = GalaryArray.imagesArray.count
            if self.indexElementToArray > 0 {
                self.indexElementToArray -= 1
            } else {
                self.indexElementToArray = quantityImages - 1
            }
        }
        mainViewImage.translatesAutoresizingMaskIntoConstraints = true
        changePriorityShowImageView()
    }
    
    func changePriorityShowImageView() {
        let temporaryBox = self.mainViewImage
        self.mainViewImage = self.hiddenViewImage
        self.hiddenViewImage = temporaryBox
    }
    
    func showDescriptionText() {
        let nameImage = GalaryArray.imagesArray[indexElementToArray]
        if let image = UserDefaults.standard.value(Images.self, forKey: nameImage) {
            self.mainTextField.text = image.description
        } else {
            self.mainTextField.text = ""
        }
    }
    
    func changeDescriptionText() {
        let nameImage = GalaryArray.imagesArray[indexElementToArray]
        guard let text = mainTextField.text else { return }
        guard let object = UserDefaults.standard.value(Images.self, forKey: nameImage) else { return }
        if text != object.description {
            let image = Images(name: nameImage, description: text)
            UserDefaults.standard.set(encodable: image, forKey: nameImage)
        }
    }
    
    func checkLikeButtonPressed() {
        let nameImage = GalaryArray.imagesArray[indexElementToArray]
        guard let image = UserDefaults.standard.value(Images.self, forKey: nameImage) else { return }
        if image.isLiked {
            self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        self.view.layoutIfNeeded()
    }
    
    func onOffLikeButton() {
        let nameImage = GalaryArray.imagesArray[indexElementToArray]
        if let image = UserDefaults.standard.value(Images.self, forKey: nameImage) {
            if image.isLiked {
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                image.isLiked = false
                UserDefaults.standard.set(encodable: image, forKey: nameImage)
            } else {
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                image.isLiked = true
                UserDefaults.standard.set(encodable: image, forKey: nameImage)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    
}




