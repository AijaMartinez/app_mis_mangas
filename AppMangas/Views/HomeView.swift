//
//  HomeView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var session: SessionManager
    
    var body: some View {
        VStack(spacing: 30){
            Text("Bienvenido a AppMangas")
                .font(.largeTitle)
            Text("Aquí podrás encontrar una lista de mangas")
            
            Button("Cerrar sesión"){
                session.logout()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView(session: SessionManager())
}
