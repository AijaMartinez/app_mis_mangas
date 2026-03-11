//
//  SessionManager.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import Foundation
internal import Combine

@MainActor
class SessionManager: ObservableObject {

    @Published var token: String? {
        didSet {
            UserDefaults.standard.set(token, forKey: "jwt_token")
        }
    }

    init() {
        self.token = UserDefaults.standard.string(forKey: "jwt_token")
    }

    var isLoggedIn: Bool {
        token != nil
    }
    
    func logout() {
        token = nil
    }
}

extension SessionManager {
    
    private var expirationKey: String { "jwt_token_expiration" }
    
    func saveToken(token: String, expiresIn: Int){
        self.token = token
        let expirationDate = Date().addingTimeInterval(TimeInterval(expiresIn))
        UserDefaults.standard.set(expirationDate, forKey: expirationKey)
    }
    
    var tokenIsValid: Bool{
        guard let expirationDate = UserDefaults.standard.object(forKey: expirationKey) as? Date else {
            return false
        }
        return Date() < expirationDate
    }
    
    func checkToken(){
        if !tokenIsValid {
            logout()
        }
    }
    
}
