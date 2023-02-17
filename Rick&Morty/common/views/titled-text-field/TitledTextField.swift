//
//  TitledTextField.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 16.02.2023.
//

import UIKit

protocol TitledTextFieldDelegate {
    func didChangeValue(currentValue: String, sender: UIView)
}

@IBDesignable
class TitledTextField: BaseView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var delegate: TitledTextFieldDelegate?
    
    @IBInspectable
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable
    var isSecureEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureEntry
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        contentView.layer.cornerRadius = 10
    }
    
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        delegate?.didChangeValue(currentValue: sender.text ?? "", sender: self)
    }
}
