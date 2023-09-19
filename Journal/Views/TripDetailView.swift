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
    @State var mapActivityID: PersistentIdentifier?
    @State var mapPosition: MapCameraPosition = .automatic
    
    var body: some View {
        GeometryReader { geometry in
            TripMap(trip: trip, mapPosition: $mapPosition)
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
            withAnimation {
                mapPosition = updateMapPosition(for: mapActivityID)
            }
        }
        .navigationTitle(trip.title)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
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
        }
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
                    coordinates = trip.steps.map(\.coordinate)
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

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    }
}
