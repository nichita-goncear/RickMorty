//
//  HomeApiManager.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import UIKit

protocol HomeApiManagerProtocol {
    func getCharacters(success: @escaping ([CharacterModel]) -> (), fail: @escaping () -> ())
    func fetchImage(urlString: String, success: @escaping (Data) -> (), fail: @escaping () -> ())
}

class HomeApiManager: HomeApiManagerProtocol {
    func getCharacters(success: @escaping ([CharacterModel]) -> (), fail: @escaping () -> ()) {
        ServiceManager.shared.getRequest(urlString: "https://rickandmortyapi.com/api/character") { (result: CharacterList) in
            success(result.results)
        } fail: {
            fail()
        }
    }
    
    func fetchImage(urlString: String, success: @escaping (Data) -> (), fail: @escaping () -> ()) {
        ServiceManager.shared.getRequest(urlString: urlString) { (imageData: Data) in
            success(imageData)
        } fail: {
            fail()
        }
    }
}
