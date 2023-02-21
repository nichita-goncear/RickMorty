//
//  UIViewController+Extensions.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import UIKit

extension UIViewController {    
    func presentAlert(title: String, msg: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAlertAction)
        
        present(alert, animated: true, completion: completion)
    }
}
