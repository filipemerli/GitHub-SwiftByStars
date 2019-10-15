//
//  GitHubSwiftRequest.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation

struct GitHubSwiftRequest {
    var path: String {
        return "search/repositories"
    }
    
    let parameters: Parameters
    private init(parameters: Parameters) {
        self.parameters = ["q": "language:swift", "sort" : "stars"]
    }
}
