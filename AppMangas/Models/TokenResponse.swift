//
//  TokenResponse.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import Foundation

struct TokenResponse: Codable {
    let token: String
    let expiresIn: Int?
    let tokenType: String?
}
