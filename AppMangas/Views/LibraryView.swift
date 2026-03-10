//
//  LibraryView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 5/03/26.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var viewModel = LibraryViewModel()
    @EnvironmentObject var session: SessionManager
    @ObservedObject var searchViewModel: SearchViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 110))
    ]
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                ScrollView {
                    if viewModel.mangas.isEmpty {
                        VStack {
                            Spacer()
                            Text("There are no saved mangas yet")
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(viewModel.mangas) { item in
                                VStack {
                                    NavigationLink(
                                        destination: MangaDetailView(
                                            mangaId: item.manga.id,
                                            viewModel: searchViewModel
                                        )
                                    ) {
                                        MangaCardView(manga: item.manga)
                                    }
                                    Button(role: .destructive) {
                                        if let token = session.token {
                                            viewModel.deleteManga(mangaId: item.manga.id, token: token)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Library")
            .task{
                if let token = session.token{
                    await viewModel.getMangas(token: token)
                }
            }
        }
    }
}

#Preview {
    LibraryView(searchViewModel: SearchViewModel())
}
