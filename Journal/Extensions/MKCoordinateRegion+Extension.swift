//
//  MKCoordinateRegion+Extension.swift
//  Journal
//
//  Created by Jill Allan on 20/09/2023.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func calculateRegion(from coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
//        let minLatitude = coordinates.map(\.latitude).min() ?? 0.0
//        let maxLatitude = coordinates.map(\.latitude).max() ?? 0.0
//        let minLongitude = coordinates.map(\.longitude).min() ?? 0.0
//        let maxLongitude = coordinates.map(\.longitude).max() ?? 0.0
        
        
//        let span2 = MKCoordinateSpan(
//            latitudeDelta: (maxLatitude - minLatitude) == 0 ? 0.002 : (maxLatitude - minLatitude) * 1.5,
//            longitudeDelta: (maxLongitude - minLongitude) == 0 ? 0.002 : (maxLongitude - minLongitude) * 1.5
//        )
        
        let center = CLLocationCoordinate2D.centre(of: coordinates)
        let span = MKCoordinateSpan.span(of: coordinates)
        
        if let center,
           let span {
            return MKCoordinateRegion(center: center, span: span)
        } else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
        }
    }
}
