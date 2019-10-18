//
//  UIImageViewExtension.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 16/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

let imgCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageWithUrl(theUrl: String, completion: @escaping (Result<ProfileImageResponse, GitHubResponseError>) -> Void) {
        let url = URL(string: theUrl)
        image = nil
        if let imageFromCache = imgCache.object(forKey: theUrl as NSString) {
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
            imgCache.setObject(downloadedImage, forKey: url!.absoluteString as NSString)
            let image = ProfileImageResponse.init(profileImage: downloadedImage)
            completion(Result.success(image))
        }).resume()
    }

}

