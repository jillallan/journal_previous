//
//  DateFormatter+Extension.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Foundation

extension DateFormatter {
    static let defaultDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static func date(fromDefault string: String) -> Date {
        return DateFormatter.defaultDateFormat.date(from: string) ?? Date.now
    }
}
