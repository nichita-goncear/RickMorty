//
//  CharacterCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 20.02.2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentBackgroundView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    
    var model: CharacterModel?
    var image: UIImage?

    static let identifier = "CharacterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CharacterCollectionViewCell", bundle: nil)
    }
    
    private func setupView() {
        contentBackgroundView.backgroundColor = .clear
        contentBackgroundView.layer.masksToBounds = true
        contentBackgroundView.layer.cornerRadius = 8
        
        shadowView.layer.shadowOpacity = 0.08
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowColor = UIColor.black.cgColor
        
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 8
    }
    
    func configure(with model: CharacterModel) {
        characterNameLabel.text = model.name
        characterOriginLabel.text = model.origin.name
    }
    
    func setAvatarImage(_ image: UIImage) {
        imageView.image = image
    }

}
