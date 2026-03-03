//
//  SearchService.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import Foundation

class SearchService{
    
    private let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/"
    
    func searchMangasContains(text: String, page: Int = 1, per: Int = 20) async throws -> MangaResponse{
        
        guard let endcodeText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw URLError(.badURL)
        }
        
        guard let url = URL(string: "\(baseURL)/search/mangasContains/\(endcodeText)?page=\(page)&per=\(per)") else{
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(MangaResponse.self, from: data)
    }
    
    func getGenres() async throws -> [String] {
        
        guard let url = URL(string: "\(baseURL)/list/genres") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else{
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([String].self, from: data)
    }
}
