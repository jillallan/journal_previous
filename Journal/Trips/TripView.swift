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
    @State var isTripEditorPresented: Bool = false
    
    var body: some View {
        let _ = logger.debug("horizontal size class: \(String(describing: horizontalSizeClass))")
        let _ = logger.debug("vertical size class: \(String(describing: verticalSizeClass))")
        let _ = logger.debug("scree size: \(String(describing: screenSize))")
        
        NavigationStack {
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Trip.self) { trip in
                TripDetailView(trip: trip)
            }
            
                        .sheet(isPresented: $isTripEditorPresented) {
                            TripEditor()
                        }
                        .toolbar {
            #if os(macOS)
                            ToolbarItem {
                                Button {
                                    isTripEditorPresented.toggle()
                                    
                                } label: {
                                    Label("Add trip", systemImage: "plus")
                                }
                            }
            #endif
            #if os(iOS)
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    isTripEditorPresented.toggle()
                                    
                                } label: {
                                    Label("Add trip", systemImage: "plus")
                                }
                            }
            #endif
                        }
        }
//        .task {
//            if trips.isEmpty {
//                PreviewContainer.insertSampleData(modelContext: modelContext)
//            }
//        }
    }
}

//#Preview("Old") {
//    ModelContainerPreview(PreviewContainer.sample) {
//        NavigationStack {
//            TripView()
//        }
//    }
//}

#Preview("New") {
    NavigationStack {
        TripView()
    }
    .journalDataContainer()
}
