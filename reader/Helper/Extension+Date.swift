//
//  Extension+Date.swift
//  reader
//
//  Created by Krina on 11/11/24.
//

import UIKit

extension Date {
    
    // Date to String conversion with caching for performance
    func toString(format: String) -> String? {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    // Time ago function
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
        formatter.maximumUnitCount = 1  // Show only the largest time unit
        formatter.unitsStyle = .full
        
        let now = Date()
        let timeInterval = now.timeIntervalSince(self)
        
        if timeInterval < 1 {
            return "Just now" // Edge case for very recent times
        }
        
        if let timeString = formatter.string(from: timeInterval) {
            return "\(timeString) ago"
        } else {
            return "Just now"
        }
    }
}

// Caching DateFormatter for better performance
extension DateFormatter {
    static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
