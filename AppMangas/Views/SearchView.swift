//
//  SearchView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    let bestManga: [Manga]
    @FocusState private var isSearchFocused: Bool
    @State private var showFilterModal = false
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                ScrollView {
                    VStack(spacing: 25) {
                        NavigationLink(value: "search") {
                            HStack{
                                Image(systemName: "magnifyingglass").foregroundStyle(Color("primaryTextColor"))
                                Text("Search mangas...")
                                    .foregroundStyle(Color.gray)
                                    .frame(height: 24)
                                Spacer()
                            }
                            .padding(10)
                            .background(Color(.systemGray5))
                            .clipShape(.buttonBorder)
                        }
                        .padding()
                        
                        GenreSectionView(viewModel: viewModel)
                        
                        BestMangasSectionView(viewModel: viewModel, mangas: bestManga)
                    }
                    .padding()
                }
                .refreshable {
                    
                }
                
                
                
                Button(action: {
                    showFilterModal = true
                }) {
                    Image(systemName: "book.pages")
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
            .background(Color("BackgroundColor"))
            .navigationDestination(for: String.self){ value in
                if value == "search"{
                    SearchBarView()
                }else{
                    MangaByGenreView(searchViewModel: viewModel, genre: value)

                }
            }
            .sheet(isPresented: $showFilterModal){
                GenreFilterModal(viewModel: viewModel)
            }
            .task {
                if viewModel.genres.isEmpty{
                    viewModel.fetchGenres()
                }
            }
        }
        
       
    }
}

#Preview {
    SearchView(bestManga: [MockData.manga])
}
