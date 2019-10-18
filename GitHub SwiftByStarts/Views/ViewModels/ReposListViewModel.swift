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
    
    public func refreshRepositories() {
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
                self.repos.removeAll()
                self.currentPage = 1
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.total = result.totalCount
                    self.repos.append(contentsOf: result.repos)
                    self.isFetching = false
                    if self.currentPage * 20 > self.currentCount {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: result.repos)
                        self.delegate?.didFetch(with: indexPathsToReload)
                    } else {
                        self.delegate?.didFetch(with: .none)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from appendRepos: [Repositorie]) -> [IndexPath] {
        let startIndex = repos.count - appendRepos.count
        let endIndex = startIndex + appendRepos.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}


