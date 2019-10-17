//
//  RepositoriesByStarsCell.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class RepositoriesByStarsCell: UITableViewCell {
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
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
    
    let activityIndicator = UIActivityIndicatorView(style: .white)

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemGray
        
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      setCell(with: .none)
    }
    
    func setCell(with repo: Repositorie?) {
      if let repo = repo {
        repoLabel.text = "Repo: \(repo.name)"
        ownerNameLabel.text = "Owner: \(repo.owner.login)"
        activityIndicator.center = profileImageView.center
        activityIndicator.startAnimating()
        
      } else {
        //activityIndicator.stopAnimating()
      }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        self.profileImageView.addSubview(activityIndicator)
        containerView.addSubview(repoLabel)
        containerView.addSubview(ownerNameLabel)
        self.contentView.addSubview(containerView)
    
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        repoLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        repoLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        repoLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        ownerNameLabel.topAnchor.constraint(equalTo: self.repoLabel.bottomAnchor).isActive = true
        ownerNameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        ownerNameLabel.topAnchor.constraint(equalTo: self.repoLabel.bottomAnchor).isActive = true
        ownerNameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
