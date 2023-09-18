//
//  TripDetailView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    
    var body: some View {
        GeometryReader { geometry in
            Map()
                .safeAreaInset(edge: .bottom) {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(trip.activities ?? []) { activity in
                                NavigationLink(value: activity) {
                                    ActivityView(activity: activity)
                                }
                            }
                        }
                        .frame(height: geometry.size.width / 1.5)
                        .navigationDestination(for: Activity.self) { activity in
                            ActivityView(activity: activity)
                        }
                    }
            }
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    }
}
