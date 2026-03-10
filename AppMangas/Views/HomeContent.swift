//
//  HomeContent.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import SwiftUI

struct HomeContent: View {
    @StateObject private var viewModel = SearchViewModel()
    let bestMangas: [Manga]
    let shounenMangas: [Manga]
    let romanceMangas: [Manga]
    let shoujoMangas: [Manga]
    let vampireMangas: [Manga]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30){
                
                Text("Mangas")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color(.yellow))
                
                SectionView(viewModel: viewModel, title: "Best Mangas", mangas: bestMangas)
                SectionView(viewModel: viewModel, title: "Shounen", mangas: shounenMangas)
                SectionView(viewModel: viewModel, title: "Romance", mangas: romanceMangas)
                SectionView(viewModel: viewModel, title: "Shoujo", mangas: shoujoMangas)
                SectionView(viewModel: viewModel, title: "Vampire", mangas: vampireMangas)
                
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
        .background(Color("BackgroundColor"))
    }
}

#Preview {

    HomeContent(bestMangas: [MockData.manga, MockData.manga, MockData.manga],
                shounenMangas: [MockData.manga, MockData.manga],
                romanceMangas: [MockData.manga], shoujoMangas: [MockData.manga], vampireMangas: [MockData.manga])
}
