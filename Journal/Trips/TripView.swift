//
//  TripView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import OSLog
import SwiftData
import SwiftUI

struct TripView: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    @Query private var trips: [Trip]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.sceneSize) private var screenSize
    @State var isAddTripViewPresented: Bool = false
    @State var navPath = NavigationPath()
  
    
    var body: some View {
        
        NavigationStack(path: $navPath) {
            ScrollView {
                LazyVStack {
                    ForEach(trips) { trip in
                        NavigationLink(value: trip) {
                            TripCard(trip: trip)
                                .scrollViewCardStyle(axes: [.horizontal], aspectRatio: 1.5, contentMode: .fill, cornerRadius: 5.0, count: 1, spacing: 10)
                        }
                    }
                }
            }
            .safeAreaPadding(20)
            .navigationTitle("Trips")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip)
            }
            .sheet(isPresented: $isAddTripViewPresented) {
                AddTripView(navigationPath: $navPath)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddTripViewPresented.toggle()
                    } label: {
                        Label("Add trip", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button("Samples") {
                        createData()
                    }
                }
            }
        }
    }
    
    func createData() {
        SampleGeneration.generateData(modelContext: modelContext)
    }
}

#Preview("New") {
    NavigationStack {
        TripView()
    }
    .journalDataContainer()
}
