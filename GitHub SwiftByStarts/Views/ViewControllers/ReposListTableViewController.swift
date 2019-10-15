//
//  ReposListTableViewController.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class ReposListTableViewController: UITableViewController {
    
    let reuseIdentifier = "ReposCell"
    let gitHubClient = GitHubAPIClient()
    private var viewModel: ReposListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(RepositoriesByStarsCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        viewModel = ReposListViewModel(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchRepositories()

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepositoriesByStarsCell
        cell.textLabel?.text = viewModel.repo(at: indexPath.row).name
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentCount
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

extension ReposListTableViewController: ReposListViewModelDelegate {
    func didFetch(with newIndexPathsToReload: [IndexPath]?) {
        print("FOI")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailFetch(with reason: String) {
        print("Falhou")
    }
    
}
