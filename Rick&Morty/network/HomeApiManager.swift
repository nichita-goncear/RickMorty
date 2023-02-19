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
}

class HomeApiManager: HomeApiManagerProtocol {
    func getCharacters(success: @escaping ([CharacterModel]) -> (), fail: @escaping () -> ()) {
        ServiceManager.shared.getRequest(urlString: "https://rickandmortyapi.com/api/character") { (result: CharacterList) in
            success(result.results)
        } fail: {
            fail()
        }

    }
}
