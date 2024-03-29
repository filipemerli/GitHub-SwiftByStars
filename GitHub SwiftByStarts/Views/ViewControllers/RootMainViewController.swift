	//
//  RootMainViewController.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 16/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class RootMainViewController: UIViewController {

    private let reposListTableViewController = UITableView()
    private let reuseIdentifier = "ReposCell"
    private var viewModel: ReposListViewModel!
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private var pullToRefresh = UIRefreshControl()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        viewModel = ReposListViewModel(delegate: self)
        reposListTableViewController.register(RepositoriesByStarsCell.self, forCellReuseIdentifier: reuseIdentifier)
        reposListTableViewController.dataSource = self
        reposListTableViewController.delegate = self
        configInitialView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        viewModel.fetchRepositories()
    }
    
    // MARK: Class Functions
    
    private func configInitialView() {
        view.addSubview(reposListTableViewController)
        reposListTableViewController.isHidden = true
        reposListTableViewController.translatesAutoresizingMaskIntoConstraints = false
        reposListTableViewController.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        reposListTableViewController.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        reposListTableViewController.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        reposListTableViewController.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.color = .systemGray
        pullToRefresh.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        pullToRefresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        reposListTableViewController.addSubview(pullToRefresh)
        
    }
    
    @objc private func refreshData() {
        viewModel.refreshRepositories()
    }
    
    private func endOfFetchRequest() {
        activityIndicator.stopAnimating()
        pullToRefresh.endRefreshing()
        reposListTableViewController.isHidden = false
        DispatchQueue.main.async {
            self.reposListTableViewController.reloadData()
        }
    }

}

    // MARK: - Table View Model Delegate
    
extension RootMainViewController: ReposListViewModelDelegate {
    func didFetch() {
        endOfFetchRequest()
    }
    
    func didFailFetch(with reason: String) {
        endOfFetchRequest()
    }
    
}

    // MARK: - Table view data source

extension RootMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currentCount
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepositoriesByStarsCell
        if !(viewModel.currentCount > 0) {
            cell.setCell(with: .none)
        } else {
            cell.setCell(with: viewModel.repo(at: indexPath.row))
        }
        return cell
    }
        
}
    
    // MARK: - Table view delegate
    
extension RootMainViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row + 3) >= viewModel.currentCount {
            viewModel.fetchRepositories()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
