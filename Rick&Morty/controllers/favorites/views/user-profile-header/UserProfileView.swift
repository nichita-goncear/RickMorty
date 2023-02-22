//
//  UserProfileView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 21.02.2023.
//

import UIKit

@IBDesignable
class UserProfileView: BaseView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        setupCornerRadius()
    }
    
    private func setupCornerRadius() {
        editButton.layer.cornerRadius = editButton.frame.size.height / 2
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    
    func configure(with model: UserModel) {
        fullNameLabel.text = model.fullName
        phoneNumberLabel.text = model.phoneNumber
    }
}
