//
//  GenreSectionView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import SwiftUI

struct GenreSectionView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {

            HStack(spacing: 15){
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ]
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.genres.prefix(6), id: \.self){ genre in
                        NavigationLink(value: genre) {
                            Text(genre)
                                .fontWidth(.condensed)
                                .frame(width: 122)
                                .foregroundStyle(Color("primaryTextColor"))
                                .padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.gray, lineWidth: 2 )
                                )
                        }
                        
                        
                    }

            }
            .background(Color("BackgroundColor"))
            .onAppear{
                Task{
                    viewModel.fetchGenres()
                }
            }
        }
    }
}

#Preview {
    GenreSectionView()
}
