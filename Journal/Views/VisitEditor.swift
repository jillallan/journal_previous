//
//  VisitEditor.swift
//  Journal
//
//  Created by Jill Allan on 19/09/2023.
//

import MapKit
import OSLog
import SwiftUI

struct VisitEditor: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    let activity: Activity?
    @State var mapPosition: MapCameraPosition = .automatic
    @State var arrivalDate: Date = Date.now
    @State var departureDate: Date = Date.now
    @State var steps: [Step] = []
    @State private var isSearchViewPresented: Bool = false
    @State private var selectedDetents: PresentationDetent = .medium
    @State var isSearching: Bool = false
    
    var body: some View {
        let _ = logger.debug("is searching: \(isSearching)")
        TripMap(steps: steps, mapPosition: $mapPosition)
        
        .safeAreaInset(edge: .bottom) {
            VStack {
                Form {
                    DatePicker("Arrival Date", selection: $arrivalDate, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("Departure Date", selection: $departureDate, displayedComponents: [.date, .hourAndMinute])
                    Button {
                        isSearchViewPresented.toggle()
                    } label: {
                        Label("Update location", systemImage: "map")
                    }
                }
                .frame(height: 200)
            }
        }
        .sheet(isPresented: $isSearchViewPresented) {
            LocationSearchView(
                searchDetentsSize: $selectedDetents
            )
            .presentationDetents(
                [.medium, .large],
                selection: $selectedDetents)
        }
        .onAppear {
            if let activity {
                arrivalDate = activity.startDate
                departureDate = activity.endDate
                steps = activity.activitySteps
                mapPosition = MapCameraPosition.region(activity.region)
                // TODO: Update mapPosition
            }
        }
    }
}

#Preview("Add visit") {
    VisitEditor(activity: nil, arrivalDate: Date.now, departureDate: Date.now)
}

#Preview("Edit visit") {
    ModelContainerPreview(PreviewContainer.sample) {
        let visit = Activity.templeMeads
        
        VisitEditor(
            activity: visit,
            arrivalDate: visit.startDate,
            departureDate: visit.endDate
        )
    }
}
