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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Rick and Morty"
        
        setupTableView()
        viewModel.fetchCharacterList()
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
        
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showFetchFailure() {
        presentAlert(title: "Oops..", msg: "Couldn't load characters.")
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
