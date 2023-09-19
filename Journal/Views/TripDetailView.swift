//
//  TripDetailView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct TripDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let trip: Trip
    @State var steps: [Step] = []
    @State var mapPosition: MapCameraPosition = .automatic
    @State var mapActivityID: PersistentIdentifier?
    
    var body: some View {
        GeometryReader { geometry in
            TripMap(steps: $steps)
                .safeAreaInset(edge: .bottom) {
                    TripActivity(trip: trip, mapActivityID: $mapActivityID)
                        .frame(height: geometry.size.width / 1.5)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            steps = trip.steps
        }
        .onChange(of: mapActivityID) {
            steps = updateSteps(for: mapActivityID)
        }
        
    }
    
    func updateSteps(for currentModelID: PersistentIdentifier?) -> [Step] {

        if let currentModelID {
            switch currentModelID.entityName {
            case "Step":
                if let step = PersistenceHelper.getStep(scrollPositionID: currentModelID, modelContext: modelContext) {
                    return [step]
                }
            case "Activity":
                if let activity = PersistenceHelper.getActivity(scrollPositionID: currentModelID, modelContext: modelContext) {
                    return activity.activitySteps
                }
            case "Trip":
                if let trip = PersistenceHelper.getTrip(scrollPositionID: currentModelID, modelContext: modelContext) {
                    return trip.steps
                }
            default:
                return []
            }
        }
        
        return []
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    }
}
