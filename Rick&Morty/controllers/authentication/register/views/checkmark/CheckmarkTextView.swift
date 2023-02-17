//
//  CheckmarkTextView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import UIKit

@IBDesignable
class CheckmarkTextView: BaseView {
    @IBOutlet weak var textLabel: UILabel!
    
    @IBInspectable
    var title: String? {
        didSet {
            textLabel.text = title
        }
    }
}
