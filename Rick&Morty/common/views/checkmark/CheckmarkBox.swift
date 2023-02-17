//
//  CheckmarkBox.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import UIKit

protocol CheckmarkBoxDelegate {
    func boxChangedState(currentState: Bool)
}

@IBDesignable
class CheckmarkBox: UIButton {
    let checkedImage = UIImage(systemName: "checkmark.square")! as UIImage
    let uncheckedImage = UIImage(systemName: "square")! as UIImage
    
    var delegate: CheckmarkBoxDelegate?
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
            
            self.delegate?.boxChangedState(currentState: isChecked)
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.tintColor = UIColor(named: "secondary")
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
