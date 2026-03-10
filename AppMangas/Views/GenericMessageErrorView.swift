//
//  GenericMessageErrorView.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 6/03/26.
//

import SwiftUI

struct GenericMessageErrorView: View {
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        if networkMonitor.isConnected == false {

            VStack {
                ContentUnavailableView(
                    "No Internet Connection",
                    systemImage: "wifi.exclamationmark",
                    description: Text("Please check your connection and try again.")
                )
                Button(action: {
                    networkMonitor.refreshConnection()
                }) {
                    Text("Retry")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(.systemGray2))
            .cornerRadius(10)
            .shadow(radius: 5)
            .ignoresSafeArea(edges: .all)
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.easeInOut, value: networkMonitor.isConnected)
            .zIndex(1)
            .onChange(of: networkMonitor.isConnected, {
                print("**** displaying connection status: \(networkMonitor.isConnected)")
            })
        }
    }
}

#Preview {
    GenericMessageErrorView()
}
