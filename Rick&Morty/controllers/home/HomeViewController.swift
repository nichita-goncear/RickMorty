//
//  HomeViewController.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel(apiManager: HomeApiManager())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.delegate = self
        
        setupTableView()
        
        viewModel.setupNetworkAlert()
        viewModel.fetchCharacterList()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Rick and Morty"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CharacterTableViewCell.nib(), forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.datasource[indexPath.row])
        
        if let imageData = viewModel.cacheImageData(for: indexPath), let image = UIImage(data: imageData) {
            cell.setImage(image)
        } else {
            viewModel.fetchImage(for: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showImageFetchFailure() {
        DispatchQueue.main.async {
            self.presentAlert(title: "Oops..", msg: "Couldn't load image.")
        }
    }
    
    func showFetchFailure() {
        DispatchQueue.main.async {
            self.presentAlert(title: "Oops..", msg: "Couldn't load characters.")
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadTableView(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func pushDetailsViewController(with viewModel: CharacterDetailsViewModel) {
        let characterDetailsViewController = CharacterDetailsViewController()
        characterDetailsViewController.viewModel = viewModel
        navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
    
    func showNetworkFailure() {
        DispatchQueue.main.async {
            self.presentAlert(title: "Oops..", msg: "Couldn't connect to network.")
        }
    }
}
