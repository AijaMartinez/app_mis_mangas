//
//  FilterModalView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 4/03/26.
//

import SwiftUI

struct GenreFilterModal: View {
    
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.genres, id: \.self) { genre in
                
                NavigationLink(destination: MangaByGenreView(searchViewModel: viewModel, genre: genre)) {
                    Text(genre)
                }
            }
            .navigationTitle("Géneros")
            .task {
                if viewModel.genres.isEmpty {
                    viewModel.fetchGenres()
                }
            }
        }
    }
}

#Preview {
    GenreFilterModal(viewModel: SearchViewModel())
}
