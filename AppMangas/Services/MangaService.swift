//
//  MangaService.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import Foundation

class MangaService{
    
    private let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/"
    
    func fetchMangas(endpoint: String, page: Int = 1, per: Int = 10) async throws -> MangaResponse{
        
        guard let url = URL(string: "\(baseURL)\(endpoint)?page=\(page)&per=\(per)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(MangaResponse.self, from: data)
    }
    
    func fetchBestMangas(endpoint: String, page: Int = 1, per: Int = 100) async throws -> MangaResponse{
        
        guard let url = URL(string: "\(baseURL)\(endpoint)?page=\(page)&per=\(per)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(MangaResponse.self, from: data)
    }
    
    
}
