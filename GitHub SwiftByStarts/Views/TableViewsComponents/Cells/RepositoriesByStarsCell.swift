//
//  RepositoriesByStarsCell.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class RepositoriesByStarsCell: UITableViewCell {
    
    private let repoNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .natural
        return label
    }()
    
//    private let profileImage : UIImageView = {
//        let image = UIImageView(image: UIImage)
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        label.textAlignment = .natural
//        return label
//    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .white)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.hidesWhenStopped = true
        repoNameLabel.center = self.center
        repoNameLabel.frame = self.frame
        activityIndicator.center = self.center
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      
      setCell(with: .none)
    }
    
    func setCell(with repo: Repositorie?) {
      if let repo = repo {
        repoNameLabel.text = "Repo: \(repo.name)"
        repoNameLabel.alpha = 1
        activityIndicator.stopAnimating()
      } else {
        repoNameLabel.alpha = 0
        activityIndicator.startAnimating()
      }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(repoNameLabel)
        addSubview(activityIndicator)
        repoNameLabel.frame = self.frame
        repoNameLabel.center = self.center
        activityIndicator.center = self.center
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
