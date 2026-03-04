//
//  GenreViewModel.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 3/03/26.
//

import Foundation
internal import Combine

@MainActor
class GenreViewModel: ObservableObject{
    @Published var mangas: [Manga] = []
    @Published var isLoading = false
    @Published var genre = ""
    
    private let service = MangaService()
    
    func loadMangas(){
        Task{
            isLoading = true
            do{
                async let mangasByGenre = service.fetchMangasByGenre(genre: genre)
                
                mangas = try await mangasByGenre.items
            }catch{
                print("Error cargando Mangas")
            }
            
            isLoading = false
        }
        
    }
}
