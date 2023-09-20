//
//  TripActivity.swift
//  Journal
//
//  Created by Jill Allan on 18/09/2023.
//

import OSLog
import SwiftData
import SwiftUI

struct TripActivity: View {
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    let trip: Trip
    @State var trips: [Trip] = []
    @State var tripActivityScrollPositionID: PersistentIdentifier?
    @Binding var mapActivityID: PersistentIdentifier?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(trips) { trip in
                    Section {
                        ForEach(trip.tripActivities) { activity in
                            NavigationLink(value: activity) {
                                if activity.activityType == .visit {
                                    VisitCard(activity: activity)
                                }
                                
                                if activity.activityType == .journey {
                                    JourneyCard(
                                        activity: activity,
                                        tripActivityScrollPositionID: $tripActivityScrollPositionID,
                                        mapActivityID: $mapActivityID
                                    )
                                }
                            }
                        }
                    } header: {
                        TripCard(trip: trip)
                    } footer: {
                        Text("Add trip")
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $tripActivityScrollPositionID)
        .contentMargins(.horizontal, 20.0)
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        
        // MARK: - Navigation
        .navigationDestination(for: Activity.self) { activity in
            if activity.activityType == .visit {
                VisitEditor(activity: activity)
            }
        }
        
        // MARK: - View Updates
        .onAppear {
            trips.append(trip)
        }
        .onChange(of: tripActivityScrollPositionID) {
            mapActivityID = tripActivityScrollPositionID
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripActivity(trip: .bedminsterToBeijing, mapActivityID: .constant(Trip.bedminsterToBeijing.persistentModelID))
        }
    }
}
