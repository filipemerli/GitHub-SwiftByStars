//
//  UserBio.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation
struct UserBio {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
    init(login: String, avatarUrl: String) {
        self.login = login
        self.avatarUrl = avatarUrl
    }
}

extension UserBio: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let login = try container.decode(String.self, forKey: .login)
        let avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.init(login: login, avatarUrl: avatarUrl)
    }
    
}
