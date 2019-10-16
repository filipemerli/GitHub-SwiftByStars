//
//  ReposListTableViewController.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class ReposListTableViewController: UITableViewController {
    
    // MARK: Properties
    
    let reuseIdentifier = "ReposCell"
    let gitHubClient = GitHubAPIClient()
    private var viewModel: ReposListViewModel!
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var pullToRefresh = UIRefreshControl()

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RepositoriesByStarsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.prefetchDataSource = self
        viewModel = ReposListViewModel(delegate: self)
        configInitialView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        viewModel.fetchRepositories()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        var safeAreaBottom: CGFloat = 0.0
//        if #available(iOS 11.0, *) {
//            safeAreaBottom = UIApplication.shared.keyWindow!.safeAreaInsets.bottom
//        }
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0.0)
//        tableView.layoutIfNeeded()
//    }
    
    
    // MARK: Class Functions
    
    @objc private func refreshData() {
        viewModel.refreshRepositories()
    }
    
    private func endOfFetchRequest() {
        activityIndicator.stopAnimating()
        pullToRefresh.endRefreshing()
    }
    
    private func configInitialView() {
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        pullToRefresh.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        pullToRefresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(pullToRefresh)
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepositoriesByStarsCell
        if isLoadingCell(for: indexPath) {
            cell.setCell(with: .none)
        } else {
            cell.setCell(with: viewModel.repo(at: indexPath.row))
        }
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
        endOfFetchRequest()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailFetch(with reason: String) {
        endOfFetchRequest()
    }
    
}

    // MARK: - Table data source prefetching

extension ReposListTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            print("VAI")
            //viewModel.fetchPopularMovies()
        }
    }
    
}
