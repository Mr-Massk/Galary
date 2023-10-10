
import Foundation
import UIKit

class Images: Codable {
    let name: String
    let description: String
    var isLiked: Bool = false
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    public enum CodingKeys: String, CodingKey {
        case name, description, isLiked
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.isLiked = try container.decode(Bool.self, forKey: .isLiked)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.isLiked, forKey: .isLiked)
    }
    
    static func saveImage(image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return nil}
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
                
            } catch let error {
                print("Couldn't remove file at path ", error)
            }
        }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print("Error saving file with error", error)
            return nil
        }
    }
    
    static func loadImage(fileName: String) -> UIImage? {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageUrl = documentsDirectory.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
    
}
