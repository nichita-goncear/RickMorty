//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 21.02.2023.
//

import Foundation
import Network

class NetworkManager {
    static let shared = NetworkManager()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
        }

        let queue = DispatchQueue(label: "NetworkManager")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
