//
//  AddMangaResponse.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 5/03/26.
//

import Foundation

struct AddMangaRequest: Codable {
    let completeCollection: Bool
    let manga: Int
    let volumesOwned: [Int]
    let readingVolume: Int
}
