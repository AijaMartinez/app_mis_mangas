//
//  SectionView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import SwiftUI

struct SectionView: View {
    
    let title: String
    let mangas: [Manga]
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(title)
                .font(.title3)
                .bold()
                .foregroundStyle(Color("BackgroundColor"))
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    ForEach(mangas){ manga in
                        MangaCardView(manga: manga)
                        
                    }
                }
            }
        }
    }
}

#Preview {

    SectionView(title: "Best Mangas", mangas: [MockData.manga])
}
