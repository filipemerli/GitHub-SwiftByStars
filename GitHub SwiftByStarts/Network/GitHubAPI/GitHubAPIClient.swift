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
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRepos(name: String,completion: @escaping (Result<[Repositorie], GitHubResponseError>) -> Void) {
        let urlRequest = URLRequest(url: endPoint)
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(GitHubResponseError.rede))
                    return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode([Repositorie].self, from: data) else {
                completion(Result.failure(GitHubResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
