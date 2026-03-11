//
//  MangaCardView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import SwiftUI
import Kingfisher

struct MangaCardView: View {
    
    let manga: Manga
    
    var body: some View {
        VStack(alignment: .leading){
            if let imageUrl = manga.mainPicture?.replacingOccurrences(of: "\"", with: ""), let url = URL(string: imageUrl){
                
                KFImage(url)
                    .placeholder{
                        ProgressView()
                    }
                    .retry(maxCount: 3, interval: .seconds(2))
                    .fade(duration: 0.25)
                    .resizable()
                    .frame(width: 120, height: 170)
                    .scaledToFill()
                    .clipped()
                    .clipShape(.rect(cornerRadius: 16))
                
            }else{
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 170)
                    .foregroundColor(.gray)
                    .clipShape(.rect(cornerRadius: 10))
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
