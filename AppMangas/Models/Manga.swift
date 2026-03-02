//
//  Manga.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import Foundation

struct Manga: Codable, Identifiable {
    let id: Int
        let title: String
        let titleJapanese: String?
        let titleEnglish: String?
        let synopsis: String?
        let background: String?
        let score: Double?
        let status: String?
        let chapters: Int?
        let volumes: Int?
        let startDate: String?
        let endDate: String?
        let mainPicture: String?
        let url: String?
        
        let authors: [Author]
        let genres: [Genre]
        let themes: [Theme]
        let demographics: [Demographic]
}
