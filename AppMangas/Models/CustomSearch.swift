//
//  CustomSearch.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import Foundation

struct CustomSearch: Codable{
    var searchTitle: String?
    var searchAuthorFirstName: String?
    var searchAuthorLastName: String?
    var searchGenres: [String]?
    var searchThemes: [String]?
    var searchDemographics: [String]?
    var searchContains: Bool
}
