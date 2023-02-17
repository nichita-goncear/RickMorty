//
//  FirebaseManager.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import FirebaseAuth

protocol FirebaseManagerProtocol {
    func registerWith(email: String, password: String, success: @escaping () -> (), fail: @escaping () -> ())
}

class FirebaseManager: FirebaseManagerProtocol {
    func registerWith(email: String, password: String, success: @escaping () -> (), fail: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            guard error == nil else {
                return fail()
            }
            
            success()
        }
    }
}
