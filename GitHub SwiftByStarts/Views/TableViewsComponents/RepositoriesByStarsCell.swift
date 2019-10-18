//
//  RepositoriesByStarsCell.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class RepositoriesByStarsCell: UITableViewCell {
    
     // MARK: Properties

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    let repoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    // MARK: Class Functions
    
    func setCell(with repo: Repositorie?) {
        activityIndicator.startAnimating()
        if let repo = repo {
            repoLabel.text = "Repo: \(repo.name)"
            let stars = repo.stars!
            ownerNameLabel.text = "Owner: \(repo.owner.login)"
            starsLabel.text = "Stars: \(stars)"
            profileImageView.loadImageWithUrl(theUrl: repo.owner.avatarUrl) { result in
                switch result {
                case .failure ( _):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.profileImageView.image = #imageLiteral(resourceName: "person_placeholder")
                    }
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.profileImageView.image = response.profileImage
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(with: .none)
        activityIndicator.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.startAnimating()
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        containerView.addSubview(repoLabel)
        containerView.addSubview(ownerNameLabel)
        containerView.addSubview(starsLabel)
        contentView.addSubview(containerView)
    
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:30).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        repoLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        repoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        repoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        ownerNameLabel.topAnchor.constraint(equalTo: repoLabel.bottomAnchor).isActive = true
        ownerNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        starsLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor).isActive = true
        starsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
