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
                
            }
            .padding()
        }
        .scrollContentBackground(.hidden)
        .background(Color("primaryTextColor"))
    }
}

#Preview {

    HomeContent(bestMangas: [MockData.manga, MockData.manga, MockData.manga],
                shounenMangas: [MockData.manga, MockData.manga],
                romanceMangas: [MockData.manga])
}
