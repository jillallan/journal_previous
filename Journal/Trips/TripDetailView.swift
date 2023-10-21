//
//  TripDetailView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import MapKit
import OSLog
import SwiftData
import SwiftUI

struct TripDetailView: View {
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.modelContext) private var modelContext
    let trip: Trip
    @State var steps: [Step] = []
    @State var mapActivityID: PersistentIdentifier?
    @State var mapPosition: MapCameraPosition = .automatic
    
    var body: some View {
        let _ = logger.debug("horizontal size class: \(String(describing: horizontalSizeClass))")
        let _ = logger.debug("vertical size class: \(String(describing: verticalSizeClass))")
        
        GeometryReader { geometry in
            let _ = logger.debug("geometry aspectRatio: \(String(describing: geometry.size.width / geometry.size.height))") 
            TripMap(steps: trip.tripSteps, mapPosition: $mapPosition)
                .safeAreaInset(edge: .bottom) {
                    TripActivity(trip: trip, viewSize: geometry.size, mapActivityID: $mapActivityID)
            }
        }
#if os(iOS)
        .toolbar(.hidden, for: .tabBar)
#endif
        .onAppear {
            steps = trip.tripSteps
        }
        .onChange(of: mapActivityID) {
            withAnimation {
                mapPosition = updateMapPosition(for: mapActivityID)
            }
        }
        .navigationTitle(trip.title)
#if os(iOS)
        .toolbarBackground(.hidden, for: .navigationBar)
#endif
        .toolbar {
#if os(macOS)
            ToolbarItem {
                Menu {
                    Button {
                        // TODO: Add visit
                        
                    } label: {
                        Label("Add visit", systemImage: "house")
                    }
                    Button {
                        // TODO: Add journey
                    } label: {
                        Label("Add journey", systemImage: "car")
                    }
                } label: {
                    Label("Add activity", systemImage: "plus")
                }
            }
#endif
#if os(iOS)
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        // TODO: Add visit
                        
                    } label: {
                        Label("Add visit", systemImage: "house")
                    }
                    Button {
                        // TODO: Add journey
                    } label: {
                        Label("Add journey", systemImage: "car")
                    }
                } label: {
                    Label("Add activity", systemImage: "plus")
                }
            }
#endif
        }
    }
    
    func addVisit() {
        // TODO: Get focused activity and set dates accordingly
        
        let newVisit = Activity(startDate: Date.now, endDate: Date.now, activityType: .visit)
    }
    
    func updateMapPosition(for currentModelID: PersistentIdentifier?) -> MapCameraPosition {
        var coordinates: [CLLocationCoordinate2D] = []

        if let currentModelID {
            switch currentModelID.entityName {
            case "Step":
                if let step = PersistenceHelper.getStep(scrollPositionID: currentModelID, modelContext: modelContext) {
                    coordinates = [step.coordinate]
                }
            case "Activity":
                if let activity = PersistenceHelper.getActivity(scrollPositionID: currentModelID, modelContext: modelContext) {
                    coordinates = activity.activitySteps.map(\.coordinate)
                }
            case "Trip":
                if let trip = PersistenceHelper.getTrip(scrollPositionID: currentModelID, modelContext: modelContext) {
                    coordinates = trip.tripSteps.map(\.coordinate)
                }
            default:
                coordinates = []
            }
        }
        
        let region = calculateCoordianteRegion(from: coordinates)
        return MapCameraPosition.region(region)
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

#Preview("New") {
    NavigationStack {
        ModelPreview { trip in
            TripDetailView(trip: trip)
        }
    }
}
