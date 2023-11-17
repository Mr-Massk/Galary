import Foundation
import UIKit

class GalaryArray: Codable {
    
    static var imagesArray: [String]  = ["1", "2", "3", "4", "5", "6", "7"] {
        didSet {
            saveArray()
        }
    }
    
    static func creatingArrayObjects() {
        for i in imagesArray {
            if let object = UserDefaults.standard.value(Images.self, forKey: i) {
                
            } else {
                let image = Images(name: i, description: "")
                UserDefaults.standard.set(encodable: image, forKey: i)
            }
        }
    }
    
    static func saveArray() {
        UserDefaults.standard.set(imagesArray, forKey: "imagesArray")
    }
    
    static func loadArray() {
        guard let array = UserDefaults.standard.value(forKey: "imagesArray") as? [String] else { return }
        imagesArray = array
    }
}
