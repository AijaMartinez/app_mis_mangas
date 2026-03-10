//
//  MangaByGenreView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import SwiftUI

struct MangaByGenreView: View {
    @StateObject private var viewModel = GenreViewModel()
    @ObservedObject var searchViewModel: SearchViewModel
    
    let genre: String
    let columns = [
        GridItem(.adaptive(minimum: 110))
    ]
    var body: some View {
            ScrollView {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }else{
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(viewModel.mangas){ manga in
                                NavigationLink(destination: MangaDetailView(mangaId: manga.id, viewModel: searchViewModel)){
                                    MangaCardView(manga: manga)
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    }
            }
            .background(Color("BackgroundColor"))
            .task {
                if viewModel.mangas.isEmpty{
                    viewModel.genre = genre
                    viewModel.loadMangas()
                }
            }
            .navigationTitle(genre)
        
           
       
        
    }
}

#Preview {
    MangaByGenreView( searchViewModel: SearchViewModel(), genre:  "JEJE SIU")
}
