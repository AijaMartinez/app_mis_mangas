//
//  SearchView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var showFilterModal = false
    
    var body: some View {
        ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                if viewModel.isLoading{
                    ProgressView()
                        .tint(.white)
                    
                }else if viewModel.results.isEmpty{
                    Text("No search results")
                        .foregroundStyle(Color.white)
                }else{
                    ScrollView{
                        let columns = [
                            GridItem(.adaptive(minimum: 110))
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(viewModel.results){
                                manga in
                                NavigationLink(destination: MangaDetailView(mangaId: manga.id, viewModel: viewModel)){
                                    MangaCardView(manga: manga)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        .overlay(alignment: .bottomTrailing){
            Button(action: {
                showFilterModal = true
            }) {
                Image(systemName: "line.3.horizontal.decrease")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color("primaryTextColor"))
                    .padding(20)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
            }
            .padding(.trailing, 20)
            .padding(.bottom, 30)
            
        }
            .sheet(isPresented: $showFilterModal){
                FilterModalView(viewModel: viewModel)
            }
            .navigationTitle("")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "Search")
            .focusable()
            .onSubmit(of: .search) {
                viewModel.search()
            }
        
    }
}

#Preview {
    SearchBarView()
}
