//
//  MangaCardView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import SwiftUI

struct MangaCardView: View {
    
    let manga: Manga
    
    var body: some View {
        VStack(alignment: .leading){
            if let imageUrl = manga.mainPicture?.replacingOccurrences(of: "\"", with: ""), let url = URL(string: imageUrl){
                
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 170)
                .cornerRadius(10)
            }
            
            Text(manga.title)
                .font(.caption)
                .lineLimit(3)
                .frame(width: 120, height: 48, alignment: .top)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color("primaryTextColor"))
        }
    }
}

#Preview {
    
    MangaCardView(manga: MockData.manga )
}
