//
//  Repositorie.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation
struct Repositorie {
    let owner: UserBio
    let name: String
    let language: String?
    let stars: Int?
    
    enum CodingKeys: String, CodingKey {
        case owner
        case name
        case language
        case stars = "stargazers_count"
    }
    
    init(owner: UserBio, name: String, language: String, stars: Int) {
        self.owner = owner
        self.name = name
        self.language = language
        self.stars = stars
    }
}

extension Repositorie: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let owner = try container.decode(UserBio.self, forKey: .owner)
        let name = try container.decode(String.self, forKey: .name)
        let language = (try? container.decode(String.self, forKey: .language)) ?? ""
        let stars = (try? container.decode(Int.self, forKey: .stars)) ?? 0
        self.init(owner: owner, name: name, language: language, stars: stars)
    }
    
}
