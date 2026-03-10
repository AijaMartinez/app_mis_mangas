//
//  UserResponse.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import Foundation

class UserService{
    private let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/"
    private let appToken = "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY"

    
    func fetchUser(token: String)  async throws -> UserResponse{
        
        guard let url = URL(string: "\(baseURL)/users/jwt/me") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(appToken, forHTTPHeaderField: "App-Token")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, 200...299 ~= http.statusCode else {
            let errorString = String(data: data, encoding: .utf8)
            print("Server response:", errorString ?? "No body")
            throw URLError(.badServerResponse)
           
        }
        
        print("Status code:", http.statusCode)

        return try JSONDecoder().decode(UserResponse.self, from: data)
    }
}
