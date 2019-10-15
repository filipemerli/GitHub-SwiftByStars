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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(RepositoriesByStarsCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let session: URLSession
        
        func fetchRepos(completion: @escaping (Result<[Repositories], GitHubResponseError>) -> Void) {
            let urlRequest = URLRequest(url: GitHubSwiftRequest)
            session.dataTask(with: urlRequest, completionHandler: { data, response, error in
                guard
                    let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                    let data = data
                    else {
                        completion(Result.failure(GitHubResponseError.rede))
                        return
                }
                
                guard let decodedResponse = try? JSONDecoder().decode([Repositories].self, from: data) else {
                    completion(Result.failure(GitHubResponseError.decoding))
                    return
                }
                completion(Result.success(decodedResponse))
            }).resume()
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
