//
//  SearchViewModel.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 27/02/26.
//

import Foundation
internal import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [Manga] = []
    @Published var genres: [String] = []
    @Published var isLoading = false
    
    private let service = SearchService()
    
    func search(){
        
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else{
            results = []
            return
        }
        
        Task{
            isLoading = true
            do{
                let response = try await service.searchMangasContains(text: searchText)
                results = response.items
            }catch{
                print("Error en busqueda")
                results = []
            }
            isLoading = false
        }
        
       
    }
    
    func fetchGenres(){
        Task{
            isLoading = true
            do{
                let response = try await service.getGenres()
                genres = response
            }catch{
                print("Error al cargar generos")
                genres = []
            }
            isLoading = false
        }
    }
    
}
