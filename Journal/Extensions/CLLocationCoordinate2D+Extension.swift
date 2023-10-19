//
//  CLLocationCoordinate2D+Extension.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import CoreLocation
import Foundation


// Added equatable conformance so we can fetch steps based on their coordinates
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    
    static func random() -> CLLocationCoordinate2D {
        let latitude = Double.random(in: -90...90)
        let longitude = Double.random(in: -180...180)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func centre(of coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D? {
        let latitude = Double.midRange(of: coordinates.map(\.latitude))
        let longitude = Double.midRange(of: coordinates.map(\.longitude))
        
        if let latitude,
           let longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
}



// Added codable conformance to enable use as a property in swift data
//extension CLLocationCoordinate2D: Codable {
//    enum CodingKeys: CodingKey {
//        case latitude
//        case longitude
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.init()
//        latitude = try container.decode(Double.self, forKey: .latitude)
//        longitude = try container.decode(Double.self, forKey: .longitude)
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(latitude, forKey: .latitude)
//        try container.encode(longitude, forKey: .longitude)
//    }
//
//    static var defaultCoordinates: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
//    }
//}
