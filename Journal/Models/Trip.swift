//
//  Trip.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Foundation
import MapKit
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
    
    var tripSteps: [Step] {
        var steps: [Step] = []
        
        _ = tripActivities.map { activity in
            steps.append(contentsOf: activity.activitySteps)
        }
        
        return steps.sorted()
    }
    
    var region: MKCoordinateRegion {
        // FIXME: Padding should be a percentage to account for changes in longitude / latitude
        MKCoordinateRegion.calculateRegion(from: tripSteps.map(\.coordinate), padding: 0.0)
    }
    
    // MARK: - Initialization
    init(title: String = "New Trip", startDate: Date = .now, endDate: Date = .now) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}

extension Trip {
    static let bedminsterToBeijing = Trip(
        title: "Bedminster to Beijing",
        startDate: Date.from(string: "2016/07/28 08:06:00"),
        endDate: Date.from(string: "2016/09/02 12:00:00") 
    )
    
    static let mountains = Trip(
        title: "Mountains",
        startDate: DateFormatter.date(fromDefault: "2016/09/03 08:06:00"),
        endDate: DateFormatter.date(fromDefault: "2016/09/30 12:00:00")
    )
}
