//
//  Trip.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Foundation
import SwiftData

@Model
class Trip {
    var title: String
    var startDate: Date
    var endDate: Date
    
    var activities: [Activity]? = []
    
    init(title: String, startDate: Date, endDate: Date) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension Trip {
    static let bedminsterToBeijing = Trip(
        title: "Bedminster to Beijing",
        startDate: DateFormatter.date(fromDefault: "2016/07/28 08:06:00"),
        endDate: DateFormatter.date(fromDefault: "2016/09/02 12:00:00")
    )
}
