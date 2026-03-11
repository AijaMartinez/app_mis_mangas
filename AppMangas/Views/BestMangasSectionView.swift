//
//  BestMangasSectionView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import SwiftUI

struct BestMangasSectionView: View {
    @ObservedObject var viewModel: SearchViewModel
    let mangas: [Manga]
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
            Text("Top Best Mangas")
                .font(.title3)
                .bold()
                .foregroundStyle(Color("primaryTextColor"))
            
            LazyVGrid(columns: columns, spacing: 10){
                    ForEach(mangas){ manga in
                        NavigationLink(destination: MangaDetailView(mangaId: manga.id, viewModel: viewModel)){
                            MangaCardView(manga: manga)
                        }
                    }
        
            }
    }
}

#Preview {
    BestMangasSectionView(viewModel: SearchViewModel(), mangas: [MockData.manga])
}
