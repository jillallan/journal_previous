//
//  TripView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftData
import SwiftUI

struct TripView: View {
    @Query private var trips: [Trip]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(trips) { trip in
                    NavigationLink(value: trip) {
                        Text(trip.title)
                    }
                }
            }
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip)
            }
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripView()
        }
    }
}
