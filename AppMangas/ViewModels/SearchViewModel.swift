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
    @Published var searchAuthorFirstName: String = ""
    @Published var searchAuthorLastName: String = ""
    @Published var results: [Manga] = []
    @Published var genres: [String] = []
    @Published var themes: [String] = []
    @Published var demographics: [String] = []
    @Published var isLoading = false
    @Published var authorFullName: String = ""
    @Published var selectedGenres: String? = nil
    @Published var selectedThemes: String? = nil
    @Published var selectedDemographics: String? = nil
    @Published var id: Int = 0
    @Published var selectedManga: Manga?
    @Published var currentPage = 1
    @Published var isLoadingMore = false
    @Published var hasMorePages = true
    
    
    private let service = SearchService()
    
    func search(){
        
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else{
            results = []
            return
        }
        
        currentPage = 1
        hasMorePages = true
        
        Task{
            isLoading = true
            do {
                let response = try await service.searchMangasContains(
                    text: searchText,
                    page: currentPage,
                    per: 20
                )
                results = response.items
            } catch {
                print("Error en busqueda")
                results = []
            }
            isLoading = false
        }
        
       
    }
    
    func fetchGenres() {
        Task {
            isLoading = true
            do {
                let response = try await service.getGenres()
                genres = response
            } catch {
                print("Error al cargar generos")
                genres = []
            }
            isLoading = false
        }
    }
    func fetchThemes() {
        Task {
            isLoading = true
            do {
                let response = try await service.getThemes()
                themes = response
            } catch {
                print("Error al cargar generos")
                themes = []
            }
            isLoading = false
        }
    }
    
    func fetchDemographics() {
        Task {
            isLoading = true
            do {
                let response = try await service.getDemographics()
                demographics = response
            } catch {
                print("Error al cargar generos")
                demographics = []
            }
            isLoading = false
        }
    }
    
    func searchWithFilters() {
        
        guard let customSearch = buildCurrentSearch() else {
            results = []
            return
        }
        
        currentPage = 1
        hasMorePages = true
        
        Task {
            isLoading = true
            
            do {
                let response = try await service.searchMangasAdvanced(
                    search: customSearch,
                    page: currentPage,
                    per: 20
                )
                
                results = response.items
                
            } catch {
                print("Error buscando mangas con filtros")
                results = []
            }
            
            isLoading = false
        }
    }
    
    func mangasById(){
        Task{
            isLoading = true
            do{
                let manga = try await service.fetchMangas(id: id)
                selectedManga = manga
            }catch{
                print("Error al cargar manga: ", error)
            }
            isLoading = false
        }
        
    }
    
    func loadMoreIfNeeded(currentItem: Manga){
        
        guard let lastItem = results.last else { return }
        
        if currentItem.id == lastItem.id && !isLoadingMore && hasMorePages {
            loadMore()
        }
    }
    
    func loadMore(){
        
        guard !isLoadingMore && hasMorePages else { return }
        
        currentPage += 1
        isLoadingMore = true
        
        Task{
            do{
                
                if let customSearch = buildCurrentSearch() {
                    
                    let response = try await service.searchMangasAdvanced(
                        search: customSearch,
                        page: currentPage,
                        per: 20
                    )
                    
                    if response.items.isEmpty {
                        hasMorePages = false
                    } else {
                        results.append(contentsOf: response.items)
                    }
                    
                } else {
                    
                    let response = try await service.searchMangasContains(
                        text: searchText,
                        page: currentPage,
                        per: 20
                    )
                    
                    if response.items.isEmpty {
                        hasMorePages = false
                    } else {
                        results.append(contentsOf: response.items)
                    }
                }
                
            } catch{
                print("Error cargando más mangas")
            }
            
            isLoadingMore = false
        }
    }
    
    func buildCurrentSearch() -> CustomSearch? {
        
        let title = searchText.trimmingCharacters(in: .whitespaces)
        let firstName = searchAuthorFirstName.trimmingCharacters(in: .whitespaces)
        let lastName = searchAuthorLastName.trimmingCharacters(in: .whitespaces)
        
        let genreArray = selectedGenres == nil ? nil : [selectedGenres!]
        let themeArray = selectedThemes == nil ? nil : [selectedThemes!]
        let demographicArray = selectedDemographics == nil ? nil : [selectedDemographics!]
        
        if title.isEmpty && firstName.isEmpty && lastName.isEmpty &&
           genreArray == nil && themeArray == nil && demographicArray == nil {
            return nil
        }
        
        return CustomSearch(
            searchTitle: title.isEmpty ? nil : title,
            searchAuthorFirstName: firstName.isEmpty ? nil : firstName,
            searchAuthorLastName: lastName.isEmpty ? nil : lastName,
            searchGenres: genreArray,
            searchThemes: themeArray,
            searchDemographics: demographicArray,
            searchContains: true
        )
    }
    
}
