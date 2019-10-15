//
//  ReposListViewModel.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation
import UIKit

protocol ReposListViewModelDelegate: class {
    func didFetch(with newIndexPathsToReload: [IndexPath]?)
    func didFailFetch(with reason: String)
}

final class ReposListViewModel {
    private weak var delegate: ReposListViewModelDelegate?
    private var repos: [Repositorie] = []
    private var currentPage = 1
    private var total = 0
    private var isFetching = false
    
    let client = GitHubAPIClient()
    
    init(delegate: ReposListViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return repos.count
    }
    
    func repo(at index: Int) -> Repositorie {
        return repos[index]
    }
    
    
    func fetchRepositories() {
        guard !isFetching else {
            return
        }
        isFetching = true
        
        client.fetchRepositories() { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetching = false
                    self.delegate?.didFailFetch(with: error.reason)
                }
            case .success(let result):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.total = result.totalCount
                    self.repos.append(contentsOf: result.repos)
                    self.isFetching = false
                    self.delegate?.didFetch(with: .none)
                }
            }
        }
    }
    
}


