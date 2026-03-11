//
//  DetailsView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 5/03/26.
//

import SwiftUI

struct MangaDetailView: View {
    @EnvironmentObject var session: SessionManager
    let mangaId: Int
    @StateObject var viewModel: SearchViewModel
    @StateObject var libraryViewModel = LibraryViewModel()
    
    let genreTagWidth: CGFloat = 90
    var body: some View {
            
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            ScrollView {
                if viewModel.isLoading{
                    ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else if let manga = viewModel.selectedManga{
                    VStack(alignment: .leading, spacing: 12){
                        Text(manga.title)
                            .font(.title)
                            .bold()
                        
                        HStack(alignment: .top, spacing: 16) {
                            if let imageUrl = manga.mainPicture?.replacingOccurrences(of: "\"", with: ""),
                               let url = URL(string: imageUrl) {
                                
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 170)
                                .cornerRadius(10)
                            }
                            
                           
                            VStack(alignment: .leading, spacing: 6) {
//                                Text("Genres:")
//                                    .font(.system(size: 17, weight: .bold))
//                                    .foregroundColor(Color("primaryTextColor"))
                                
                                
                                FlowLayout(data: manga.genres, spacing: 8) { genre in
                                    NavigationLink(destination: MangaByGenreView(searchViewModel: viewModel, genre: genre.genre)) {
                                        Text(genre.genre)
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(Color("primaryTextColor"))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(Color.purple.opacity(0.3))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                                            }
                        }
                        Text("Author: ")
                            .font(.title)
                            .bold()
                        FlowLayout(data: manga.authors, spacing: 8) { author in
                            Text("\(author.firstName) \(author.lastName)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("primaryTextColor"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                
                        }
                        
                        Text("Themes: ")
                            .font(.title)
                            .bold()
                        FlowLayout(data: manga.themes, spacing: 8) { theme in
                            Text(theme.theme)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("primaryTextColor"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.pink.opacity(0.2))
                                .cornerRadius(8)
                                
                        }
                        
                        Text("Demographics: ")
                            .font(.title)
                            .bold()
                        FlowLayout(data: manga.demographics, spacing: 8) { demographics in
                            Text(demographics.demographic)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("primaryTextColor"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)
                                
                        }

                        if let caps = manga.chapters{
                            Text("Chapters: \(caps)")
                                .font(.system(size: 20, weight: .bold))
                        }
                        if let volumes = manga.volumes{
                            Text("Volumes: \(volumes)")
                                .font(.system(size: 20, weight: .bold))
                        }
                        if let score = manga.score{
                            Text("Score: \(String(format: "%.2f", score))")
                                .font(.system(size: 20, weight: .bold))
                        }
                        if manga.startDate != nil{
                            var formattedStartDate: String {
                                guard let dateString = manga.startDate else { return "Unknown" }
                                let isoFormatter = ISO8601DateFormatter()
                                isoFormatter.formatOptions = [.withInternetDateTime]
                                
                                if let date = isoFormatter.date(from: dateString) {
                                    let formatter = DateFormatter()
                                    formatter.dateStyle = .medium
                                    formatter.timeStyle = .none
                                    return formatter.string(from: date)
                                }
                                return "Invalid date"
                            }
                            Text("Start Date: \(formattedStartDate)")
                                .font(.system(size: 20, weight: .bold))
                        }
                        if manga.endDate != nil{
                            var formattedStartDate: String {
                                guard let dateString = manga.endDate else { return "Unknown" }
                                let isoFormatter = ISO8601DateFormatter()
                                isoFormatter.formatOptions = [.withInternetDateTime]
                                
                                if let date = isoFormatter.date(from: dateString) {
                                    let formatter = DateFormatter()
                                    formatter.dateStyle = .medium
                                    formatter.timeStyle = .none
                                    return formatter.string(from: date)
                                }
                                return "Invalid date"
                            }
                            Text("End Date: \(formattedStartDate)")
                                .font(.system(size: 20, weight: .bold))
                        }
                        
                        if let synopsis = manga.synopsis {
                            Text("Synopsis:")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(synopsis)
                        }
                        
                        if libraryViewModel.isMangaInLibrary(mangaId: mangaId) {

                            Button {
                                if let token = session.token {
                                        libraryViewModel.deleteManga(mangaId: mangaId, token: token)
                                }
                            } label: {
                                Label("Remove to library", systemImage: "trash")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemRed).opacity(0.5))
                                    .foregroundColor(Color("primaryTextColor"))
                                    .cornerRadius(12)
                            }

                        } else {

                            Button {
                                if let token = session.token {
                                    libraryViewModel.addManga(mangaId: mangaId, token: token)
                                }
                            } label: {
                                Label("Add to Library", systemImage: "plus.circle.fill")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemMint).opacity(0.5))
                                    .foregroundColor(Color("primaryTextColor"))
                                    .cornerRadius(12)
                            }
                        }
                        
                    }
                    .padding()
                }else{
                    Text("No manga found")
                }
            }
            
            .task {
                viewModel.id = mangaId
                viewModel.mangasById()
                
                if let token = session.token{
                    await libraryViewModel.getMangas(token: token)
                }
            }
        }
        
    }
}

#Preview {
    MangaDetailView(mangaId: 1, viewModel: SearchViewModel())
}
