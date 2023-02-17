//
//  TitledTextField.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 16.02.2023.
//

import UIKit

@IBDesignable
class TitledTextField: BaseView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBInspectable
    var title: String? {
        didSet {
            titleLabel.text = title
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
}
