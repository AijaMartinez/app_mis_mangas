//
//  AuthService.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import Foundation

class AuthService {
    
    private let baseURL = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com"
    private let appToken = "sLGH38NhEJ0_anlIWwhsz1-LarClEohiAHQqayF0FY"

    func register(email:String, password:String) async throws{

        guard let url = URL(string: "\(baseURL)/users") else{
            throw URLError(.badURL)
        }

        let body = RegisterRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appToken, forHTTPHeaderField: "App-Token")
        request.httpBody = try JSONEncoder().encode(body)

        let (_, response) = try await URLSession.shared.data(for: request)
        print(response)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }
    }

    func login(email: String, password: String) async throws -> TokenResponse {

        // Construye la url
        guard let url = URL(string: "\(baseURL)/users/jwt/login") else { throw URLError(.badURL) }

        // Concatena la credenciales
        let credentials = "\(email):\(password)"

        // Convierte las credenciales en binario
        guard let data = credentials.data(using: .utf8) else { throw URLError(.badURL) }
        print("data: \(data)")

        // Convierte el data en base64
        let base64Credentials = data.base64EncodedString()
        print("base64: \(base64Credentials)")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")

        // Hace la peticion
        let (dataResponse, response ) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw URLError(.userAuthenticationRequired)
        }

        return try JSONDecoder().decode(TokenResponse.self, from: dataResponse)
    }
    
    
}
