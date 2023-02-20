//
//  HomeViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showFetchFailure()
    func showImageFetchFailure()
    func reloadTableView()
    func reloadTableView(at indexPath: IndexPath)
    
    func pushDetailsViewController(with viewModel: CharacterDetailsViewModel)
}

class HomeViewModel {
    var datasource = [CharacterModel]()
    
    var delegate: HomeViewModelDelegate?
    var apiManager: HomeApiManagerProtocol
    var cacheManager: CacheManager
    
    init(apiManager: HomeApiManagerProtocol, delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
        self.apiManager = apiManager
        self.cacheManager = CacheManager()
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
    
    func cacheImageData(for indexPath: IndexPath) -> Data? {
        let imageUrlString = datasource[indexPath.row].imageUrlString
        return cacheManager.getImageData(urlString: imageUrlString)
    }
    
    func fetchImage(for indexPath: IndexPath) {
        let urlString = datasource[indexPath.row].imageUrlString
        apiManager.fetchImage(urlString: urlString) { imageData in
            self.cacheManager.insertImageData(imageData, urlString: urlString)
            self.delegate?.reloadTableView(at: indexPath)
        } fail: {
            self.delegate?.showImageFetchFailure()
        }

    }
    
    // MARK: Presentation
    
    func didSelectRow(at indexPath: IndexPath) {
        let characterModel = datasource[indexPath.row]
        let charactersWithSameOrigin = datasource.filter { $0.origin.name == characterModel.origin.name && $0.name != characterModel.name }
        
        let characterDetailsViewModel = CharacterDetailsViewModel(
            characterModel: characterModel,
            similarCharactersDatasource: charactersWithSameOrigin,
            apiManager: apiManager,
            cacheManager: cacheManager)
        
        delegate?.pushDetailsViewController(with: characterDetailsViewModel)
    }
}
