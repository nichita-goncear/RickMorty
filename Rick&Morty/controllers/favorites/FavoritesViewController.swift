//
//  FavoritesViewController.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 20.02.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = FavoritesViewModel(apiManager: HomeApiManager(), firebaseManager: FirebaseManager())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Rick and Morty"
        
        setupCollectionView()
        viewModel.loadFavoriteCharacters()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CharacterCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.datasource[indexPath.row])
        
        if let imageData = viewModel.cacheImageData(for: indexPath), let image = UIImage(data: imageData) {
            cell.setAvatarImage(image)
        } else {
            viewModel.fetchImage(for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = CGFloat(16 * 3)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let width = availableWidth / 2
        let height = 1.5 * width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        viewModel.didTapLogOut()
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func showLogOutFailure() {
        DispatchQueue.main.async {
            self.presentAlert(title: "Oops..", msg: "Couldn't sign out.")
        }
    }
    
    func showImageFetchFailure() {
        DispatchQueue.main.async {
            self.presentAlert(title: "Oops..", msg: "Couldn't load image.")
        }
    }
    
    func reloadCollectionView(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func presentSignInController() {
        // TODO: Presentation 
    }
}
