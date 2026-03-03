//
//  HomeContent.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import SwiftUI

struct HomeContent: View {
    
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
                
                SectionView(title: "Best Mangas", mangas: bestMangas)
                SectionView(title: "Shounen", mangas: shounenMangas)
                SectionView(title: "Romance", mangas: romanceMangas)
                SectionView(title: "Shoujo", mangas: shoujoMangas)
                SectionView(title: "Vampire", mangas: vampireMangas)
                
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
