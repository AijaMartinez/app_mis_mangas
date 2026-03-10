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

    var isLoggedIn: Bool{
        token != nil
    }
    
    func logout(){
        token = nil
    }
}
