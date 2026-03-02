//
//  HomeTabBar.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import SwiftUI

struct HomeTabBar: View {
    @ObservedObject var session: SessionManager
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showSearch = false
    
    var body: some View {
        TabView{
            NavigationStack {
                HomeContent(
                    bestMangas: viewModel.bestMangas,
                    shounenMangas: viewModel.shounenMangas,
                    romanceMangas: viewModel.romanceMangas
                )
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            showSearch = true
                        }){
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
                .navigationTitle("")
                .navigationDestination(isPresented: $showSearch){
                    SearchView()
                }
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(0)
            
            Text("Buscar")
                .tabItem {
                    Image(systemName: "text.page.badge.magnifyingglass")
                }
                .tag(1)
            
            Text("Bibliotecas")
                .tabItem {
                    Image(systemName: "books.vertical")
                }
                .tag(2)
            
            Text("Perfil")
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
        }.tint(.orange)
        
    }
}


#Preview {

    HomeTabBar(session: SessionManager())
}
