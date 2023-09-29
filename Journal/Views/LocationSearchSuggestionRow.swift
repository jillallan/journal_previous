//
//  LocationSearchSuggestionRow.swift
//  Journal
//
//  Created by Jill Allan on 22/09/2023.
//

import MapKit
import SwiftUI

struct LocationSearchSuggestionRow: View {
    let mapItem: MKMapItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mapItem.placemark.title)
                .font(.headline)
            Text(mapItem.placemark.subTitle)
                .font(.subheadline)
            Divider()
            Group {
                Text(mapItem.placemark.name ?? "no name")
                Text(mapItem.placemark.areasOfInterest?.first ?? "No area of interest")
                Text(mapItem.placemark.jointThoroughfare ?? "no thorouhfare")
                    .font(.subheadline)
                Text(mapItem.placemark.jointLocality ?? "no locality")
                    .font(.subheadline)
                Text(mapItem.placemark.jointAdministrativeArea ?? "no administrative area")
                    .font(.subheadline)
                Text(mapItem.placemark.country ?? "no country")
                Text(mapItem.placemark.inlandWater ?? "No inland water")
                Text(mapItem.placemark.ocean ?? "No ocean")
            }.font(.caption)
        }
    }
}

#Preview {
    
    LocationSearchSuggestionRow(
        mapItem: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.449667, longitude: -2.583172)))
    )
}
