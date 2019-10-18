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
    func didFetch()
    func didFailFetch(with reason: String)
}

final class ReposListViewModel {
    
    // MARK: Properties
    
    private weak var delegate: ReposListViewModelDelegate?
    private var repos: [Repositorie] = []
    public var currentPage = 1
    private var total = 0
    private var isFetching = false
    
    private let client = GitHubAPIClient()
    
    public var totalCount: Int {
        return total
    }
    
    public var currentCount: Int {
        return repos.count
    }
    
    // MARK: Initializer
    
    init(delegate: ReposListViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: Class Functions
    
    public func repo(at index: Int) -> Repositorie {
        return repos[index]
    }
    
    public func fetchRepositories() {
        guard !isFetching else {
            return
        }
        isFetching = true
        client.fetchRepositories(page: currentPage) { result in
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
                    self.isFetching = false
                    self.repos.append(contentsOf: result.repos)
                    self.delegate?.didFetch()
                }
            }
        }
    }
    
    public func refreshRepositories() {
        guard !isFetching else {
            return
        }
        isFetching = true
        client.fetchRepositories(page: 1) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetching = false
                    self.delegate?.didFailFetch(with: error.reason)
                }
            case .success(let result):
                self.currentPage = 1
                DispatchQueue.main.async {
                    self.repos.removeAll()
                    self.currentPage += 1
                    self.repos.append(contentsOf: result.repos)
                    self.isFetching = false
                    self.delegate?.didFetch()
                }
            }
        }
    }
    
}


