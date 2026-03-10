//
//  User.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import Foundation

struct UserResponse: Codable, Identifiable{
    let role: String
    var isActive: Bool
    var isAdmin: Bool
    var email: String
    let id: String
    
}
