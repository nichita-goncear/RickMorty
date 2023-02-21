//
//  HomeViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation
import Network

protocol HomeViewModelDelegate: AnyObject {
    func showFetchFailure()
    func showImageFetchFailure()
    func showNetworkFailure()
    func reloadTableView()
    func reloadTableView(at indexPath: IndexPath)
    
    func pushDetailsViewController(with viewModel: CharacterDetailsViewModel)
}

class HomeViewModel {
    var datasource = [CharacterModel]()
    
    var delegate: HomeViewModelDelegate?
    var apiManager: HomeApiManagerProtocol
    var cacheManager: CacheManager
    var networkManager: NetworkManager
    
    init(apiManager: HomeApiManagerProtocol, delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
        self.apiManager = apiManager
        self.cacheManager = CacheManager()
        self.networkManager = NetworkManager()
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
    
    func setupNetworkAlert() {
        networkManager.monitor.pathUpdateHandler = { path in
           if path.status != .satisfied {
               self.delegate?.showNetworkFailure()
           }
        }
        
        let queue = DispatchQueue(label: "NetworkManager")
        networkManager.monitor.start(queue: queue)
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
