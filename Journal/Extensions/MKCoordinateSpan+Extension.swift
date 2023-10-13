//
//  MKCoordinateSpan+Extension.swift
//  Journal
//
//  Created by Jill Allan on 13/10/2023.
//

import Foundation
import MapKit

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        return lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateSpan {
    static func span(of coordinates: [CLLocationCoordinate2D]) -> MKCoordinateSpan? {
        let latitude = Double.range(of: coordinates.map(\.latitude))
        let longitude = Double.range(of: coordinates.map(\.longitude))
        
        if let latitude,
           let longitude {
            
            // If the latitude or longitude is 0 create a small lat or long
            // TODO: Check this is needed
            
            return MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)
//            return MKCoordinateSpan(
//                latitudeDelta: latitude == 0.0 ? 0.002 : latitude * 1.5,
//                longitudeDelta: longitude == 0.0 ? 0.002 : longitude * 1.5
//            )
        } else {
            return nil
        }
    }
}
