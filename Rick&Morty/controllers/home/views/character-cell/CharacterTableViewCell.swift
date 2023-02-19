//
//  CharacterTableViewCell.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentBackgroundView: UIView!
    
    static let identifier = "CharacterTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        contentBackgroundView.backgroundColor = .clear
        contentBackgroundView.layer.masksToBounds = true
        
        shadowView.layer.shadowOpacity = 0.08
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowColor = UIColor.black.cgColor
        
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 8
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CharacterTableViewCell", bundle: nil)
    }
    
    func configure(with model: CharacterModel) {
        characterNameLabel.text = model.name
        characterSpeciesLabel.text = model.species
        characterOriginLabel.text = model.origin.name
    }
    
    func setImage(_ image: UIImage) {
        // TODO: Set imageView when finished
    }
}
