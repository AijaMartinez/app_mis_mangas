//
//  Author.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import Foundation

struct Author: Codable, Identifiable{
    let id: String
    let firstName: String
    let lastName: String
    let role: String
}
