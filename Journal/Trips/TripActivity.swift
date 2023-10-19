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
    
    @Environment(\.sceneAspectRatio) private var sceneAspectRatio
    
    let trip: Trip
    let viewSize: CGSize
    @State var trips: [Trip] = []
    @State var tripActivityScrollPositionID: PersistentIdentifier?
    @Binding var mapActivityID: PersistentIdentifier?
    
    var cardCount: Int {
        switch viewSize.width / viewSize.height {
        case 1.515...:
            return 3
        case 1..<1.515:
            return 2
        case ..<1:
            return 1
        default:
            return 1
        }
    }
    
    var aspectRatio: Double {
        Double(cardCount) * 1.5
    }
    
    var body: some View {
        let _ = logger.debug("viewSize aspectRatio: \(String(describing: viewSize.width / viewSize.height))")
        
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
                            .buttonStyle(.plain)
                            .scrollViewCardStyle(axes: [.horizontal], aspectRatio: 1.5, contentMode: .fit, cornerRadius: 5.0, count: cardCount, spacing: 10)
                        }
                    } header: {
                        TripCard(trip: trip)
                            .scrollViewCardStyle(axes: [.horizontal], aspectRatio: 1.5, contentMode: .fit, cornerRadius: 5.0, count: cardCount, spacing: 10)
                    }
                    // FIXME: Add invisible footer to get the scroll view to the end to update the map
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $tripActivityScrollPositionID)
        .contentMargins(.horizontal, 20.0)
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .frame(height: viewSize.width / aspectRatio)
        
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
    ModelPreview { (model: Trip) in
        GeometryReader { geometry in
            NavigationStack {
                TripActivity(trip: .bedminsterToBeijing, viewSize: geometry.size, mapActivityID: .constant(Trip.bedminsterToBeijing.persistentModelID))
            }
        }
    }
}
