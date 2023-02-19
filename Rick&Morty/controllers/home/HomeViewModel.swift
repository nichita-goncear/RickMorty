//
//  HomeViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showFetchFailure()
    func reloadTableView()
}

class HomeViewModel {
    var datasource = [CharacterModel]()
    
    var delegate: HomeViewModelDelegate?
    var apiManager: HomeApiManagerProtocol
    
    init(apiManager: HomeApiManagerProtocol, delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
        self.apiManager = apiManager
    }
    
    convenience init(apiManager: HomeApiManagerProtocol) {
        self.init(apiManager: apiManager, delegate: nil)
    }
    
    func fetchCharacterList() {
        apiManager.getCharacters { characterList in
            self.datasource = characterList
            self.delegate?.reloadTableView()
        } fail: {
            self.delegate?.showFetchFailure()
        }

    }
}
