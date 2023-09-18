//
//  Step.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import CoreLocation
import Foundation
import SwiftData

@Model
class Step {
    // MARK: - Properties
    var timestamp: Date
    var latitude: Double
    var longitude: Double
    var altitude: Double = 0.0
    var horizontalAccuracy: Double = 0.0
    var verticalAccuracy: Double = 0.0
    
    // MARK: - Relationships
    var activity: Activity?
    var placemark: Placemark?
    
    // MARK: - Computed Properties
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var placemarkName: String {
        placemark?.name ?? "Unknown Place"
    }
    
    var debugDescription: String {
        return "timestamp: \(timestamp), coordinate: \(coordinate), name: \(placemarkName)"
    }
    
    // MARK: - Initialization
    init(timestamp: Date, latitude: Double, longitude: Double, altitude: Double, horizontalAccuracy: Double, verticalAccuracy: Double) {
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
    }
}

// Added comparable comformance to enable sorting by timestamp
extension Step: Comparable {
    public static func < (lhs: Step, rhs: Step) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}

extension Step {
    static let templeMeadsStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 08:40:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.449667, longitude: -2.583172),
        latitude: 51.449667,
        longitude: -2.583172,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )

    static let bathSpaStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 09:41:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.377827, longitude: -2.356904),
        latitude: 51.377827,
        longitude: -2.356904,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )
    
    static let chippenhamStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 09:54:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.462365, longitude: -2.115312),
        latitude: 51.462365,
        longitude: -2.115312,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )
    
    static let swindonStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 10:08:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.565890, longitude: -1.7855841),
        latitude: 51.565890,
        longitude: -1.7855841,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )
    
    
    static let didcotStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 10:27:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.611101, longitude: -1.2427116),
        latitude: 51.611101,
        longitude: -1.2427116,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )
    
    
    static let readingStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 10:41:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.458524, longitude: -0.9714477),
        latitude: 51.458524,
        longitude: -0.9714477,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )
    
    static let paddingtonStation = Step(
        timestamp: DateFormatter.date(fromDefault: "2016-07-28 11:07:00"),
//        coordinate: CLLocationCoordinate2D(latitude: 51.516725, longitude: -0.177346),
        latitude: 51.516725,
        longitude: -0.177346,
        altitude: 0.0,
        horizontalAccuracy: 0.0,
        verticalAccuracy: 0.0
    )
}
