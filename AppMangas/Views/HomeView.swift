//
//  HomeView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var session: SessionManager
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        HomeTabBar(session: session, viewModel: viewModel)
            .onAppear {
                viewModel.loadHome()
            }
    }
}

#Preview {
    HomeView(session: SessionManager())
}
