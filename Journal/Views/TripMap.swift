//
//  TripMap.swift
//  Journal
//
//  Created by Jill Allan on 19/09/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct TripMap: View {
    @Binding var steps: [Step]
    @State var mapPosition: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $mapPosition) {
            // TODO: Add annotations
            ForEach(steps) { step in
                
                if step.activity?.activityType == .visit {
                    Annotation("", coordinate: step.coordinate) {
                        Circle()
                            .size(width: 24, height: 24)
                            .fill(.indigo)
                    }
                }
                
                if step.activity?.activityType == .journey {
                    Annotation("", coordinate: step.coordinate) {
                        Circle()
                            .size(width: 12, height: 12)
                            .fill(.indigo)
                    }
                }
            }
            MapPolyline(coordinates: steps.map(\.coordinate))
                .stroke(.indigo, lineWidth: 3)
        }
        .onChange(of: steps) {
            withAnimation {
                mapPosition = updateMapPosition(for: steps)
            }
            
        }
    }
    
    func updateMapPosition(for steps: [Step]) -> MapCameraPosition {
        let region = calculateCoordianteRegion(from: steps.map(\.coordinate))
        return MapCameraPosition.region(region)
    }
    
    
    func calculateCoordianteRegion(from coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion {

        let minLatitude = coordinates.map(\.latitude).min() ?? 0.0
        let maxLatitude = coordinates.map(\.latitude).max() ?? 0.0
        let minLongitude = coordinates.map(\.longitude).min() ?? 0.0
        let maxLongitude = coordinates.map(\.longitude).max() ?? 0.0
        
        let center = CLLocationCoordinate2D(
            latitude: (minLatitude + maxLatitude) / 2,
            longitude: (minLongitude + maxLongitude) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLatitude - minLatitude) == 0 ? 0.002 : (maxLatitude - minLatitude) * 1.5,
            longitudeDelta: (maxLongitude - minLongitude) == 0 ? 0.002 : (maxLongitude - minLongitude) * 1.5
        )
        return MKCoordinateRegion(center: center, span: span)
    }
}

#Preview("Trip") {
    TripMap(steps: .constant(Trip.bedminsterToBeijing.steps))
}

#Preview("Visit") {
    TripMap(steps: .constant(Activity.templeMeads.activitySteps))
}
