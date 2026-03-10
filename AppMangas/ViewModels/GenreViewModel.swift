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
    @Published var currentPage = 1
    @Published var isLoadingMore = false
    @Published var hasMorePages = true
    
    private let service = MangaService()
    
    func loadMangas(){
        
        currentPage = 1
        hasMorePages = true
        Task{
            isLoading = true
            do{
                async let mangasByGenre = service.fetchMangasByGenre(
                    genre: genre,
                    page: currentPage,
                    per: 20
                )
                
                mangas = try await mangasByGenre.items
            }catch{
                print("Error cargando Mangas")
            }
            
            isLoading = false
        }
        
    }
    
    func loadMoreIfNeeded(currentItem: Manga){
        
        guard let lastItem = mangas.last else { return }
        
        if currentItem.id == lastItem.id && !isLoadingMore && hasMorePages {
            loadMore()
        }
    }
    
    func loadMore(){
    
        
        currentPage += 1
        isLoadingMore = false
        
        Task{
            do{
                let response = try await service.fetchMangasByGenre(
                    genre: genre,
                    page: currentPage
                )
                
                if response.items.isEmpty {
                    hasMorePages = false
                }else{
                    mangas.append(contentsOf: response.items)
                }
                
            } catch{
                print("Error cargando mangas")
            }
            
            isLoadingMore = false
        }
    }
}
