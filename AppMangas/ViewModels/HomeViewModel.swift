//
//  HomeViewModel.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 26/02/26.
//

import Foundation
internal import Combine

@MainActor
class HomeViewModel: ObservableObject{
    
    @Published var bestMangas: [Manga] = []
    @Published var shounenMangas: [Manga] = []
    @Published var romanceMangas: [Manga] = []
    
    @Published var isLoading = false
    
    private let service = MangaService()
    
    func loadHome(){
        Task{
            isLoading = true
            do{
                async let best = service.fetchMangas(endpoint: "list/bestMangas")
                async let shounen = service.fetchMangas(endpoint: "list/mangaByDemographic/Shounen")
                async let romance = service.fetchMangas(endpoint: "list/mangaByGenre/Romance")
                
                bestMangas = try await best.items
                shounenMangas = try await shounen.items
                romanceMangas = try await romance.items
                
                
            }catch{
                print("Error cargando Home")
            }
            isLoading = false
        }
    }
}
