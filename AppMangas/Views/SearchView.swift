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
   
    var body: some View {
        
        NavigationStack {
            ScrollView{
                VStack(spacing: 25){
                    NavigationLink(value: "search") {
                        HStack{
                            Image(systemName: "magnifyingglass").foregroundStyle(Color.white)
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
                    
                    GenreSectionView()
                    Spacer()
                    
                    BestMangasSectionView(mangas: bestManga)
                
                }
                
            }
            .background(Color("BackgroundColor"))
            .navigationDestination(for: String.self){ value in
                if value == "search"{
                    SearchBarView()
                }else{
                    MangaByGenreView(genre: value)
                }
                
            }
            

        }
       
        
        
       
    }
}

#Preview {
    SearchView(bestManga: [MockData.manga])
}
