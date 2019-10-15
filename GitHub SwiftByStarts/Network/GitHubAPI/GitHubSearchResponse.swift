//
//  GitHubSearchResponse.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Catarino Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation

struct GitHubSearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let repos: [Repositorie]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repos = "items"
    }
}
