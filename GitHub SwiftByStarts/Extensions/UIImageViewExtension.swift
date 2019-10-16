//
//  UIImageViewExtension.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 16/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

let imgCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImageWithUrl(posterUrl: String, completion: @escaping (Result<ProfileImageResponse, GitHubResponseError>) -> Void) {
        let urlConcat = "https://image.tmdb.org/t/p/w500" + posterUrl
        let url = URL(string: urlConcat)
        image = nil
        if let imageFromCache = imgCache.object(forKey: urlConcat as AnyObject) as? UIImage {
            self.image = imageFromCache
            let poster = ProfileImageResponse.init(profileImage: self.image!)
            completion(Result.success(poster))
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(GitHubResponseError.rede))
                    return
            }
            let downloadedImage = UIImage(data: data)!
            imgCache.setObject(downloadedImage, forKey: urlConcat as AnyObject)
            let image = ProfileImageResponse.init(profileImage: downloadedImage)
            completion(Result.success(image))
        }).resume()
    }
    
}
