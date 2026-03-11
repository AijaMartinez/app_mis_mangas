//
//  NetworkManager.swift
//  AppMangas
//
//  Created by Osvaldo Mercado on 6/03/26.
//

import Network
import SwiftUI
internal import Combine

class NetworkMonitor: ObservableObject {

    private var monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        startMonitoring()
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(appDidBecomeActive),
                name: UIApplication.didBecomeActiveNotification,
                object: nil
        )
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.isConnected = (path.status == .satisfied)
                print("Connection status:", path.status)
                print("WiFi:", path.usesInterfaceType(.wifi))
                print("Cellular:", path.usesInterfaceType(.cellular))
            }
        }
        monitor.start(queue: queue)
    }
    
    @objc private func appDidBecomeActive() {
        refreshConnection()
    }
    
    func refreshConnection() {
        monitor.cancel()
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    deinit {
        monitor.cancel()
        NotificationCenter.default.removeObserver(self)
    }
    
}
