//
//  TripActivityScrollView.swift
//  Journal
//
//  Created by Jill Allan on 18/09/2023.
//

import SwiftUI

struct TripActivityScrollView: View {
    let trip: Trip
    @State var trips: [Trip] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(trips) { trip in
                    Section {
                        ForEach(trip.activities ?? []) { activity in
                            NavigationLink(value: activity) {
                                ActivityView(activity: activity)
                            }
                        }
                    } header: {
                        TripCard(trip: trip)
                    } footer: {
                        Text("Add trip")
                    }
                }
            }
        }
        
        .navigationDestination(for: Activity.self) { activity in
            ActivityView(activity: activity)
        }
        .onAppear {
            trips.append(trip)
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        TripActivityScrollView(trip: .bedminsterToBeijing)
    }
}
