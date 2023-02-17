//
//  BaseView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 16.02.2023.
//

import Foundation
import UIKit

class BaseView: UIView {
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        contentView = loadViewFromNib()
        addSubview(contentView)
        contentView.stickToView(self)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
