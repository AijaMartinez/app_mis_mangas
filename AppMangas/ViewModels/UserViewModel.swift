//
//  UserViewModel.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import Foundation
internal import Combine
import SwiftUI

@MainActor
class UserViewModel: ObservableObject{
    @Published var userRes:  UserResponse? = nil
    @Published var isLoading = false
    
    private let service = UserService()
 
    
    
    func loadUser(token: String){
        
        
        print("Token:", token)
        Task{
            isLoading = true
            do{
                let user = try await service.fetchUser(token: token)
                userRes = user
            }catch{
                print("Error:", error)
            }
            isLoading = false
            
        }
    }
}
