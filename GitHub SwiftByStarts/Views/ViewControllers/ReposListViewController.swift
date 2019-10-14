//
//  ReposListViewController.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Catarino Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class ReposListViewController: UIViewController {
    
    // MARK: Properties
    
    let reposLisTableView = UITableView()
    var reposListTableViewsafeArea: UILayoutGuide!
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .lightGray
        setupReposListTableView()
    }
    
    // MARK: Class Functions
    
    private func setupReposListTableView() {
        view.addSubview(reposLisTableView)
        reposListTableViewsafeArea = view.layoutMarginsGuide
        reposLisTableView.translatesAutoresizingMaskIntoConstraints = false
        reposLisTableView.topAnchor.constraint(equalTo: reposListTableViewsafeArea.topAnchor).isActive = true //Possivel erro caso
        reposLisTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        reposLisTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        reposLisTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}
