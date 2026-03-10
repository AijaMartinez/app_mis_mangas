//
//  CollectionManga.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 5/03/26.
//

import Foundation

struct CollectionManga: Codable, Identifiable {
    let id: String
    let readingVolume: Int
    let volumesOwned: [Int]
    let completeCollection: Bool
    let manga: Manga
}
