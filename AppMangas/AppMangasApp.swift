//
//  AppMangasApp.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 25/02/26.
//

import SwiftUI
import CoreData

@main
struct AppMangasApp: App {
    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                HomeView(session: session)
            } else{
                LoginView(viewModel: LoginViewModel(session: session))
            }
        }
    }
}
