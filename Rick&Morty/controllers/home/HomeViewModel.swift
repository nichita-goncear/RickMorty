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
    
    private func setImageCache(imageData: Data) {
        // TODO: Set image cache
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
        // TODO: Search in cache 
        return nil
    }
    
    func fetchImage(for indexPath: IndexPath) {
        let urlString = datasource[indexPath.row].imageUrlString
        apiManager.fetchImage(urlString: urlString) { image in
            // TODO: Finish after caching manager done
            self.delegate?.reloadTableView(at: indexPath)
        } fail: {
            self.delegate?.showImageFetchFailure()
        }

    }
}
