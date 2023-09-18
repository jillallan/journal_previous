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
    // MARK: - Properties
    var title: String
    var startDate: Date
    var endDate: Date
    
    // MARK: - Relationships
    var activities: [Activity]? = []
    
    // MARK: - Computed Properties
    var tripActivities: [Activity] {
        activities?.sorted() ?? []
    }
    
    var debugDescription: String {
        "Trip named: \(title)"
    }
    
    var steps: [Step] {
        var steps: [Step] = []
        
        _ = tripActivities.map { activity in
            steps.append(contentsOf: activity.activitySteps)
        }
        
        return steps.sorted()
    }
    
    // MARK: - Initialization
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
