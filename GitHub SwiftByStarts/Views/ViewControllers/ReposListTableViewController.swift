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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(RepositoriesByStarsCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gitHubClient.fetchRepositories() { result in
                   switch result {
                   case .failure( _):
                       print("ERRO")
                   case .success( _):
                    print("FOI")
                   }
               }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepositoriesByStarsCell
        cell.textLabel?.text = "VAI"
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
