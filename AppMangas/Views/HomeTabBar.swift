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
    @StateObject var searchViewModel = SearchViewModel()
    
    @State private var showSearch = false
    
    var body: some View {
        TabView{
            NavigationStack {
                HomeContent(
                    bestMangas: viewModel.bestMangas,
                    shounenMangas: viewModel.shounenMangas,
                    romanceMangas: viewModel.romanceMangas,
                    shoujoMangas: viewModel.shoujoMangas,
                    vampireMangas: viewModel.vampiresMangas,
                )
                
            }
            .tabItem {
                Image(systemName: "house")
            }
            .tag(0)
            
            SearchView(bestManga: viewModel.bestMang)
                .tabItem {
                    
                    Image(systemName: "text.page.badge.magnifyingglass")
                }
                .tag(1)
            
            LibraryView(searchViewModel: searchViewModel)
                .tabItem {
                    Image(systemName: "books.vertical")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
        }
        .tint(.orange)
    }
}

#Preview {

    HomeTabBar(session: SessionManager())
}
