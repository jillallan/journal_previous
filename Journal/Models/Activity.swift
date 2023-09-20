//
//  Activity.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Foundation
import MapKit
import SwiftData

enum ActivityType: Codable {
    case visit, journey
}

@Model
class Activity {
    // MARK: - Properties
    var startDate: Date
    var endDate: Date
    var activityType: ActivityType
    
    // MARK: - Relationships
    var steps: [Step]? = []
    var trip: Trip?
    @Relationship(inverse: \Activity.suceedingActivity)
    var proceedingActivity: Activity?
    var suceedingActivity: Activity?
    
    // MARK: - Computed Properties
    var activitySteps: [Step] {
        var journeySteps = steps ?? []
        
        if activityType == .journey {
            if let proceedingActivityStep = proceedingActivity?.steps?.first {
                journeySteps.append(proceedingActivityStep)
            }
            
            if let succeedingActivityStep = suceedingActivity?.steps?.first {
                journeySteps.append(succeedingActivityStep)
            }
        }
        return journeySteps.sorted()
    }
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion.calculateRegion(from: activitySteps.map(\.coordinate))
    }
    
    var debugDescription: String {
        return "activity type: \(activityType), start date: \(startDate), steps: \(String(describing: steps))"
    }
    
    // MARK: - Initialization
    init(startDate: Date, endDate: Date, activityType: ActivityType) {
        self.startDate = startDate
        self.endDate = endDate
        self.activityType = activityType
    }
}

extension Activity: Comparable {
    static func < (lhs: Activity, rhs: Activity) -> Bool {
        lhs.startDate < rhs.startDate
    }
}

extension Activity {
    static let templeMeads = Activity(
        startDate: DateFormatter.date(fromDefault: "2016-07-28 08:40:00"),
        endDate: DateFormatter.date(fromDefault: "2016-07-28 09:35:00"),
        activityType: .visit
    )
    
    static let templeMeadsToPaddington = Activity(
        startDate: DateFormatter.date(fromDefault: "2016-07-28 09:36:00"),
        endDate: DateFormatter.date(fromDefault: "2016-07-28 11:06:00"),
        activityType: .journey
    )
    
    static let paddington = Activity(
        startDate: DateFormatter.date(fromDefault: "2016-07-28 11:07:00"),
        endDate: DateFormatter.date(fromDefault: "2016-07-28 11:15:00"),
        activityType: .visit
    )
}
