//
//  BestMangasSectionView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import SwiftUI

struct BestMangasSectionView: View {
    
    let mangas: [Manga]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            Text("Top Best Mangas")
                .font(.title3)
                .bold()
                .foregroundStyle(Color("primaryTextColor"))
            
            LazyVGrid(columns: columns, spacing: 10){
                    ForEach(mangas){ manga in
                        MangaCardView(manga: manga)
                    }
        
            }
    }
}

#Preview {
    BestMangasSectionView(mangas: [MockData.manga])
}
