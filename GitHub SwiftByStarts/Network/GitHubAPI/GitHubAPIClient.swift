//
//  GitHubAPIClient.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation
final class GitHubAPIClient {
    private lazy var endPoint: URL = {
        return URL(string: "https://api.github.com")!
    }()
    
    let session: URLSession
    let defaultParameters = ["q": "language:swift", "sort" : "stars"]
    let paginationParameters = ["page": "1", "per_page" : "20"]
    let path = "search/repositories"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRepositories(completion: @escaping (Result<GitHubSearchResponse, GitHubResponseError>) -> Void) {
        let urlRequest = URLRequest(url: endPoint.appendingPathComponent(path))
        
        let parameters = defaultParameters.merging(paginationParameters, uniquingKeysWith: +)
        let encodedURLRequest = urlRequest.encode(with: parameters)
      
        print("Request = \(encodedURLRequest)")
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
        guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.hasSuccessStatusCode,
        let dados = data
        else {
            
            completion(Result.failure(GitHubResponseError.rede))
            return
        }
            guard let decodedResponse = try? JSONDecoder().decode(GitHubSearchResponse.self, from: dados) else {
            completion(Result.failure(GitHubResponseError.decoding))
            return
        }
        completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
