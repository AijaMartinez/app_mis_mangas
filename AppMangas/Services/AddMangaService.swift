//
//  AddMangaService.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 5/03/26.
//

import Foundation

class AddMangaService {
    
    private let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com"
    
    func addMangaToCollection(mangaId: Int, token: String) async {
        guard let url = URL(string: "\(baseURL)/collection/manga") else{
            return
        }
        
        let body = AddMangaRequest(
            completeCollection: false,
            manga: mangaId,
            volumesOwned: [],
            readingVolume: 0
        )
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = try JSONEncoder().encode(body)
                
            let (_, response) = try await URLSession.shared.data(for: request)
                
            if let httpResponse = response as? HTTPURLResponse {
                print("Status:", httpResponse.statusCode)
            }
                
        } catch {
            print("Error adding manga:", error)
        }
    }
    
    func getMangaCollection(token: String) async throws -> [CollectionManga]{
        
        guard let url = URL(string: "\(baseURL)/collection/manga") else{
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
                
        guard let http = response as? HTTPURLResponse,
              200...299 ~= http.statusCode else{
            let error = String(data:data, encoding: .utf8)
            print("Server response:", error ?? "No body")
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([CollectionManga].self, from: data)
    }
    
    func deleteMangaFromCollection(mangaId: Int, token: String) async{
        
        guard let url = URL(string: "\(baseURL)/collection/manga/\(mangaId)") else{
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
            let (_, response) = try await URLSession.shared.data(for: request)
                
            if let httpResponse = response as? HTTPURLResponse {
                print("Status:", httpResponse.statusCode)
            }
                
        } catch {
            print("Error deleting manga:", error)
        }
                
        
    }
}
