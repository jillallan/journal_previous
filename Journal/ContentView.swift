//
//  ContentView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    
    var body: some View {
        TabView {
            TripView()
                .tabItem {
                    Label("Trips", systemImage: "suitcase")
                }
            LocationSearchView(isLocationSearchViewSearching: .constant(false))
                .tabItem {
                    Label("Search", systemImage: "suitcase")
                }
        }
        .task {
            if trips.isEmpty {
                PreviewContainer.insertSampleData(modelContext: modelContext)
            }
            
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        ContentView()
    }
}
