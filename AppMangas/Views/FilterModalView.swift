//
//  FilterModalView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 4/03/26.
//

import SwiftUI

struct FilterModalView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    
                    Text("Filter Options")
                    Spacer()
                    TextField("Author's name",text: $viewModel.searchAuthorFirstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocorrectionDisabled(true)
                    TextField("Author's lastname",text: $viewModel.searchAuthorLastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocorrectionDisabled(true)
                    
                    VStack(alignment: .leading, spacing: 30){
                        Text("Genres")
                            .font(.headline)
                        
                        Picker("Select a genre", selection: Binding(
                            get: { viewModel.selectedGenres ?? "" },
                            set: { viewModel.selectedGenres = $0.isEmpty ? nil : $0 }
                        )){
                            Text("None").tag("")
                            ForEach(viewModel.genres, id: \.self){ genre in
                                Text(genre).tag(genre)
                                
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Text("Themes")
                            .font(.headline)
                        Picker("Select a theme", selection: Binding(
                            get: { viewModel.selectedThemes ?? "" },
                            set: { viewModel.selectedThemes = $0.isEmpty ? nil : $0 }
                        )){
                            Text("None").tag("")
                            ForEach(viewModel.themes, id: \.self){ theme in
                                Text(theme).tag(theme)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Text("Demographics")
                            .font(.headline)
                        Picker("Select a demographic", selection: Binding(
                            get: { viewModel.selectedDemographics ?? "" },
                            set: { viewModel.selectedDemographics = $0.isEmpty ? nil : $0 }
                        )){
                            Text("None").tag("")
                            ForEach(viewModel.demographics, id: \.self){ demographic in
                                Text(demographic).tag(demographic)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        
                    }
                    .padding(.horizontal)
                    
                    Button("Filter"){
                        viewModel.searchWithFilters()
                        dismiss()
                    }
                    .font(.title2)
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .frame(maxWidth: .infinity)
                    
                    Button("Close"){
                        dismiss()
                    }
                    .padding()
                }
                .navigationTitle("Filter")
                .padding()
                .task {
                    if viewModel.genres.isEmpty{
                        viewModel.fetchGenres()
                    }
                    if viewModel.themes.isEmpty{
                        viewModel.fetchThemes()
                    }
                    
                    if viewModel.demographics.isEmpty{
                        viewModel.fetchDemographics()
                    }
                }
            }
        }
    }
}

#Preview {
    FilterModalView(viewModel: SearchViewModel())
}
