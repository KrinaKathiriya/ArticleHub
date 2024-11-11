//
//  ReachabilityManager.swift
//  Reader
//
//  Created by Krina on 10/11/24.
//

import Reachability
import XCGLogger

class ReachabilityManager {
    
    private let reachability = try! Reachability()
    private let logger = XCGLogger.default
    
    /// Property to check if the network is connected.
    var isConnected: Bool {
        return reachability.connection != .unavailable
    }
    
    /// Starts network reachability monitoring and logs the current connection status.
    func startMonitoring() {
        reachability.whenReachable = { [weak self] reachability in
            guard let self = self else { return }
            
            if reachability.connection == .wifi {
                self.logger.info("Network reachable via WiFi")
            } else if reachability.connection == .cellular {
                self.logger.info("Network reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { [weak self] _ in
            self?.logger.warning("Network not reachable")
        }
        
        do {
            try reachability.startNotifier()
            logger.info("Started network reachability monitoring")
        } catch {
            logger.error("Unable to start network notifier: \(error.localizedDescription)")
        }
    }
    
    /// Stops network reachability monitoring and logs the action.
    func stopMonitoring() {
        reachability.stopNotifier()
        logger.info("Stopped network reachability monitoring")
    }
}
