//
//  File.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import Foundation

struct MangaResponse: Codable{
    let items: [Manga]
    let metadata: Metadata
}
