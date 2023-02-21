//
//  FavoritesViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 20.02.2023.
//

import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    func showLogOutFailure()
    func showImageFetchFailure()
    func reloadCollectionView(at indexPath: IndexPath)
    func presentSignInController()
}

class FavoritesViewModel {
    var datasource = [
        CharacterModel(name: "Vincent van Gogh", status: .dead, origin: CharacterModel.CharacterOriginModel(name: "Netherlands"), location: CharacterModel.CharacterLocationModel(name: "Berlin"), imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male"),
        CharacterModel(name: "Vincent van Gogh", status: .dead, origin: CharacterModel.CharacterOriginModel(name: "Netherlands"), location: CharacterModel.CharacterLocationModel(name: "Berlin"), imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male"),
        CharacterModel(name: "Vincent van Gogh", status: .dead, origin: CharacterModel.CharacterOriginModel(name: "Netherlands"), location: CharacterModel.CharacterLocationModel(name: "Berlin"), imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male"),
        CharacterModel(name: "Vincent van Gogh", status: .dead, origin: CharacterModel.CharacterOriginModel(name: "Netherlands"), location: CharacterModel.CharacterLocationModel(name: "Berlin"), imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male"),
        CharacterModel(name: "Vincent van Gogh", status: .dead, origin: CharacterModel.CharacterOriginModel(name: "Netherlands"), location: CharacterModel.CharacterLocationModel(name: "Berlin"), imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male"),
        CharacterModel(name: "Vincent van Gogh", status: .dead, origin: CharacterModel.CharacterOriginModel(name: "Netherlands"), location: CharacterModel.CharacterLocationModel(name: "Berlin"), imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male"),
    ]
    
    var delegate: FavoritesViewModelDelegate?
    var apiManager: HomeApiManagerProtocol
    var firebaseManager: FirebaseManagerProtocol
    var cacheManager: CacheManager
    
    // TODO: Implement CoreDataManager
//    var coreDataManager: CoreDataManager()
    
    init(apiManager: HomeApiManagerProtocol, firebaseManager: FirebaseManagerProtocol) {
        self.apiManager = apiManager
        self.firebaseManager = firebaseManager
        self.cacheManager = CacheManager()
    }
    
    func loadFavoriteCharacters() {
        
    }
    
    func didTapLogOut() {
        firebaseManager.logOut {
            self.delegate?.presentSignInController()
        } fail: {
            self.delegate?.showLogOutFailure()
        }

    }
    
    func cacheImageData(for imageUrlString: String) -> Data? {
        return cacheManager.getImageData(urlString: imageUrlString)
    }
    
    func cacheImageData(for indexPath: IndexPath) -> Data? {
        let imageUrlString = datasource[indexPath.row].imageUrlString
        return cacheManager.getImageData(urlString: imageUrlString)
    }
    
    func fetchImage(for urlString: String) {
        apiManager.fetchImage(urlString: urlString) { imageData in
            self.cacheManager.insertImageData(imageData, urlString: urlString)
        } fail: {
            self.delegate?.showImageFetchFailure()
        }
    }
    
    func fetchImage(for indexPath: IndexPath) {
        let urlString = datasource[indexPath.row].imageUrlString
        apiManager.fetchImage(urlString: urlString) { imageData in
            self.cacheManager.insertImageData(imageData, urlString: urlString)
            self.delegate?.reloadCollectionView(at: indexPath)
        } fail: {
            self.delegate?.showImageFetchFailure()
        }
    }
}
