//
//  CharacterHeaderView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 20.02.2023.
//

import UIKit

class CharacterHeaderView: BaseView {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentBackgroundView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationValueLabel: UILabel!
    @IBOutlet weak var genderValueLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var statusIndicatorImageView: UIImageView!
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with model: CharacterModel, image: UIImage?) {
        imageView.image = image
        
        locationValueLabel.text = model.location.name
        genderValueLabel.text = model.gender
        statusValueLabel.text = model.status.rawValue
        sectionTitleLabel.text = "Also from \(model.origin.name)"
        
        switch model.status {
        case .alive:
            statusIndicatorImageView.tintColor = .green
        case .dead:
            statusIndicatorImageView.tintColor = .red
        case .unknown:
            statusIndicatorImageView.tintColor = .yellow
        }
    }
    
    func setAvatarImage(_ image: UIImage) {
        imageView.image = image
    }
}
