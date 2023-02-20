//
//  CharacterDetailsViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 20.02.2023.
//

import Foundation

protocol CharacterDetailsViewModelDelegate {
    func showFetchFailure()
    func showImageFetchFailure()
    func reloadTableView()
    func reloadTableView(at indexPath: IndexPath)
    func reloadHeaderView()
}

class CharacterDetailsViewModel {
    var characterModel: CharacterModel
    var similarCharactersDatasource = [CharacterModel]()
    
    var delegate: CharacterDetailsViewModelDelegate?
    var apiManager: HomeApiManagerProtocol
    var cacheManager: CacheManager
    
    init(characterModel: CharacterModel, similarCharactersDatasource: [CharacterModel] = [CharacterModel](), apiManager: HomeApiManagerProtocol, cacheManager: CacheManager) {
        self.characterModel = characterModel
        self.similarCharactersDatasource = similarCharactersDatasource
        self.apiManager = apiManager
        self.cacheManager = cacheManager
    }
    
    func cacheImageData(for imageUrlString: String) -> Data? {
        return cacheManager.getImageData(urlString: imageUrlString)
    }
    
    func cacheImageData(for indexPath: IndexPath) -> Data? {
        let imageUrlString = similarCharactersDatasource[indexPath.row].imageUrlString
        return cacheManager.getImageData(urlString: imageUrlString)
    }
    
    func fetchImage(for urlString: String) {
        apiManager.fetchImage(urlString: urlString) { imageData in
            self.cacheManager.insertImageData(imageData, urlString: urlString)
            self.delegate?.reloadHeaderView()
        } fail: {
            self.delegate?.showImageFetchFailure()
        }
    }
    
    func fetchImage(for indexPath: IndexPath) {
        let urlString = similarCharactersDatasource[indexPath.row].imageUrlString
        apiManager.fetchImage(urlString: urlString) { imageData in
            self.cacheManager.insertImageData(imageData, urlString: urlString)
            self.delegate?.reloadTableView(at: indexPath)
        } fail: {
            self.delegate?.showImageFetchFailure()
        }
    }
}
