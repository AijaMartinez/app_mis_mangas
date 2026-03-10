//
//  GenreSectionView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import SwiftUI

struct GenreSectionView: View {
    @ObservedObject var viewModel: SearchViewModel

    let columns = [
        GridItem(.adaptive(minimum: 110), spacing: 15)
    ]

    var body: some View {

        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(viewModel.genres.prefix(6), id: \.self) { genre in
                
                NavigationLink(value: genre) {
                    Text(genre)
                        .fontWidth(.condensed)
                        .foregroundStyle(Color("primaryTextColor"))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 2)
                        )
                }
            }
        }
        .padding(.horizontal)
    }
}
#Preview {
    GenreSectionView(viewModel: SearchViewModel())
}
