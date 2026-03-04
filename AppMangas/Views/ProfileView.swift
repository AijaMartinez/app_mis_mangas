//
//  ProfileView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var viewModel = UserViewModel()
        
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            VStack(spacing: 20){
                Image("mnsterfondo").resizable().scaledToFill().frame(width: 300, height: 250).clipShape(Circle())
                if viewModel.isLoading{
                    ProgressView().tint(.white)
                }else if let user = viewModel.userRes{
                    VStack(spacing: 15){
                        Text("Email: \(user.email)").foregroundStyle(Color("primaryTextColor")).bold()
                        Text("Role: \(user.role)").foregroundStyle(Color("primaryTextColor")).bold()
                        Text("Active: \(user.isActive ? "Si" : "No")").foregroundStyle(Color("primaryTextColor")).bold()
                        Text("Admin: \(user.isAdmin ? "Si" : "No")").foregroundStyle(Color("primaryTextColor")).bold()
                    }
                } else {
                    Text("No user data")
                        .foregroundStyle(.white)
                }
                
                Button(action: {
                    session.logout()
                }){
                    Text("Cerrar Sesion")
                        .foregroundStyle(Color("primaryTextColor"))
                        .padding()
                        .background(Color.blue)
                        .clipShape(.buttonBorder)
                }
            }
        }
        .navigationTitle("Profile")
        .task {
            if let token = session.token{
                viewModel.loadUser(token: token)
            }
        }
    }
}

#Preview {
    ProfileView()
}
