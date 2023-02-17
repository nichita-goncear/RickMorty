//
//  UIViewController+Extensions.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAlertAction)
        
        present(alert, animated: true)
    }
}
