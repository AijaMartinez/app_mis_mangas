//
//  LibraryViewModel.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 5/03/26.
//

import Foundation
internal import Combine
import SwiftUI

class LibraryViewModel: ObservableObject{
    
    @Published var mangas: [CollectionManga] = []
    private let service = AddMangaService()
    @Published var isLoading = false
    @Published var successMessage: String?
    @Published var errorMessage: String?
    
    func addManga(mangaId: Int, token: String){
        isLoading = true
        
        Task{
            await service.addMangaToCollection(mangaId: mangaId, token: token)
            
            await MainActor.run {
                isLoading = false
            }
            successMessage = "Manga added to library"
            
            await getMangas(token: token)
        }
        
    }
    
    func getMangas(token: String) async{
        isLoading = true
        Task{
            
            do{
                let manga = try await service.getMangaCollection(token: token)
                await MainActor.run {
                    mangas = manga
                    isLoading = false
                }
            }catch{
                print("Error de al cargar mangas")
            }
            await MainActor.run {
                isLoading = false
            }
        }
    }
    
    func deleteManga(mangaId:Int, token: String){
        isLoading = true
        
        Task{
            
            await service.deleteMangaFromCollection(mangaId: mangaId, token: token)
            
            await MainActor.run {
                withAnimation{
                    mangas.removeAll { $0.manga.id == mangaId }
                }
                isLoading = false
                successMessage = "Manga deleted from library"
            }
        }
    }
    
    func isMangaInLibrary(mangaId: Int) -> Bool {
        mangas.contains { $0.manga.id == mangaId }
    }
    
}
