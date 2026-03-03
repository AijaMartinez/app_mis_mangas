//
//  SearchView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject private var viewModel = SearchViewModel()
    var body: some View {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                if viewModel.isLoading{
                    ProgressView()
                        .tint(.white)
                }else if viewModel.results.isEmpty{
                    Text("Sin resultados")
                        .foregroundStyle(Color.white)
                }else{
                    ScrollView{
                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(viewModel.results){
                                manga in MangaCardView(manga: manga)
                            }
                        }
                        .padding()
                    }
                }
                
                
            }
            .navigationTitle("")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
            .onSubmit(of: .search) {
                viewModel.search()
            }
            .navigationBarBackButtonHidden(false)
                
        
        
        
    }
}

#Preview {
    SearchBarView()
}
