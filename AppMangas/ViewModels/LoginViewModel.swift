//
//  LoginViewModel.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import SwiftUI
internal import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var registrationSuccess = false
    
    private let service = AuthService()
    @ObservedObject private var session: SessionManager
    
    init(session: SessionManager){
        self.session = session
    }
    
    func register(){
        guard isValidEmail(email) else{
            errorMessage = "Email invalido"
            return
        }
        
        guard isValidPassword(password) else{
            errorMessage = "La contraseña debe tener minimo 8 caracteres"
            return
        }
        

        Task {
            isLoading = true
            errorMessage = nil
            do{
                try await service.register(email: email, password: password)
                registrationSuccess = true
            } catch{
                errorMessage = "Error al registrar"
            }
            isLoading = false
        }
    }
    
    func login(){
        guard isValidEmail(email) else{
            errorMessage = "Email invalido"
            return
        }
        
        guard isValidPassword(password) else{
            errorMessage = "La contraseña debe tener minimo 8 caracteres"
            return
        }
        
        
        
        Task{
            isLoading = true
            errorMessage = nil
            do{
                let response = try await service.login(email: email, password: password)
                
                
                session.saveToken(token: response.token, expiresIn: response.expiresIn ?? 3600)
                
                print("JWT:", response.token)
                password = ""
            }catch{
                errorMessage = "Credenciales incorrectas"
            }
            isLoading = false
        }
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            .evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
}
