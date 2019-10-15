//
//  GitHubResponseError.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Merli on 15/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import Foundation
enum GitHubResponseError: Error {
    case rede
    case decoding
    
    var reason: String {
        switch self {
        case .rede:
            return "Erro de rede. Por favor verifique sua conexão"
        case .decoding:
            return "Erro de comunicação com o servidor. Em breve voltaremos."
        }
    }
}
