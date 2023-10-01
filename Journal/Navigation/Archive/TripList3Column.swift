//
//  TripList3Column.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftData
import SwiftUI

struct TripList3Column: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Query private var trips: [Trip]
    @Binding var selectedTrip: Trip?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(trips) { trip in
                    
                    Group {
                        if prefersTabNavigation {
                            NavigationLink(value: trip) {
                                TripCard(trip: trip)
                            }
                        } else {
                            TripCard(trip: trip)
                        }
                    }
                    
                    .scrollViewCardStyle(axes: [.horizontal], aspectRatio: 1.5, contentMode: .fill, cornerRadius: 5.0, count: 1, spacing: 10)
                    
                    .if(!prefersTabNavigation) { view in
                        view.onTapGesture {
                            selectedTrip = trip
                        }
                    }
                    
                }
            }
        }
        .safeAreaPadding(5)
        .navigationTitle("Trips")
        .navigationBarTitleDisplayMode(.inline)
        
        .if(prefersTabNavigation) { view in
            view.navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip)
            }
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        TripList3Column(selectedTrip: .constant(Trip.bedminsterToBeijing))
    }
    
}
