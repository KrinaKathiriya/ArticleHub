//
//  Extension+String.swift
//  reader
//
//  Created by Krina on 11/11/24.
//

import UIKit

extension String {
    
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent parsing
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC time zone
        return dateFormatter.date(from: self)
    }
}
