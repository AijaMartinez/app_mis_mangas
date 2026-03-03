//
//  MangaByGenreView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 2/03/26.
//

import SwiftUI

struct MangaByGenreView: View {
    let genre: String
    var body: some View {
        Text("Select Genre \(genre)")
            .navigationTitle(genre)
    }
}

#Preview {
    MangaByGenreView(genre:  "JEJE SIU")
}
