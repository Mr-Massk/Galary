import Foundation
import UIKit

class MainViewSettings {
    
    static func setMainViewParameters(mainViewSettings: UIView, superView: UIView) {
        mainViewSettings.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainViewSettings.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor,constant: 0),
            mainViewSettings.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor,constant: 0),
            mainViewSettings.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor,constant: 0),
            mainViewSettings.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor,constant: 0)
        ])
        
    }
}

