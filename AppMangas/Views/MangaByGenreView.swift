//
//  MangaByGenreView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import SwiftUI

struct MangaByGenreView: View {
    @StateObject private var viewModel = GenreViewModel()
    let genre: String
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }else{
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(viewModel.mangas){ manga in
                                MangaCardView(manga: manga)
                            }
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .background(Color("BackgroundColor"))
                .onAppear() {
                    viewModel.genre = genre
                    viewModel.loadMangas()
                }
                .navigationTitle(genre)
        
           
       
        
    }
}

#Preview {
    MangaByGenreView( genre:  "JEJE SIU")
}
