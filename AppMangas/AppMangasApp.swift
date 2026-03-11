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
    @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ZStack {
                GenericMessageErrorView()

                if session.isLoggedIn {
                    HomeView(session: session)
                        .environmentObject(session)
                } else{
                    LoginView(viewModel: LoginViewModel(session: session))
                }
            }
            .onAppear{
                session.checkToken()
            }
            .environmentObject(networkMonitor)
        }
    }
}
