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
    
    func getThemes() async throws -> [String] {
        
        guard let url = URL(string: "\(baseURL)/list/themes") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else{
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func getDemographics() async throws -> [String] {
        
        guard let url = URL(string: "\(baseURL)/list/demographics") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else{
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func searchMangasAdvanced(search: CustomSearch, page: Int = 1, per: Int = 100) async throws -> MangaResponse{
        
        guard let url = URL(string: "\(baseURL)/search/manga?page=\(page)&per=\(per)") else{
            throw URLError(.badURL)
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(search)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else{
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(MangaResponse.self, from: data)
    }
    
    func fetchMangas(id: Int) async throws -> Manga{
        
        guard let url = URL(string: "\(baseURL)/search/manga/\(id)") else{
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else{
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(Manga.self, from: data)
    }
}
