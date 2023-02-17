//
//  CheckmarkTextView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import UIKit

protocol CheckmarkTextViewDelegate {
    func didChangeState(currentState: Bool)
}

@IBDesignable
class CheckmarkTextView: BaseView {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var checkmarkBox: CheckmarkBox!
    
    var delegate: CheckmarkTextViewDelegate?
    
    @IBInspectable
    var title: String? {
        didSet {
            textLabel.text = title
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
        checkmarkBox.delegate = self
    }
}

extension CheckmarkTextView: CheckmarkBoxDelegate {
    func boxChangedState(currentState: Bool) {
        delegate?.didChangeState(currentState: currentState)
    }
}
