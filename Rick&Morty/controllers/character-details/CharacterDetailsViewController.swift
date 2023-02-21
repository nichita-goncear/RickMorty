//
//  CharacterDetailsViewController.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 20.02.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CharacterDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.characterModel.name
        
        setupTableView()
        setupBackButton()
    }
    
    private func setupBackButton() {
        let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = newBackButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CharacterTableViewCell.nib(), forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.similarCharactersDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.similarCharactersDatasource[indexPath.row])
        
        if let imageData = viewModel.cacheImageData(for: indexPath), let image = UIImage(data: imageData) {
            cell.setImage(image)
        } else {
            viewModel.fetchImage(for: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CharacterHeaderView()

        let characterModel = viewModel.characterModel

        if let characterImageData = viewModel.cacheImageData(for: characterModel.imageUrlString), let image = UIImage(data: characterImageData) {
            headerView.configure(with: viewModel.characterModel, image: image)
        } else {
            headerView.configure(with: characterModel, image: nil)
            viewModel.fetchImage(for: characterModel.imageUrlString)
        }

        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewModelDelegate {
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
    
    func reloadHeaderView() {
        guard
            let headerView = tableView.tableHeaderView as? CharacterHeaderView,
            let characterImageData = viewModel.cacheImageData(for: viewModel.characterModel.imageUrlString),
            let image = UIImage(data: characterImageData)
        else { return }
        
        headerView.setAvatarImage(image)
    }
    
    func pushDetailsViewController(with viewModel: CharacterDetailsViewModel) {
        let characterDetailsViewController = CharacterDetailsViewController()
        characterDetailsViewController.viewModel = viewModel
        navigationController?.pushViewController(characterDetailsViewController, animated: true)
    }
    
    func popToHomeViewController() {
        for controller in navigationController?.viewControllers ?? [] {
            if let homeVC = controller as? HomeViewController {
                navigationController?.popToViewController(homeVC, animated: true)
            }
        }
    }
}
