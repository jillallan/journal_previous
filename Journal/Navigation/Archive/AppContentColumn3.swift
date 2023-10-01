//
//  AppContentColumn3.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftUI

struct AppContentColumn3: View {
    var screen: AppScreen3Column?
    @Binding var selectedTrip: Trip?
    
    var body: some View {
        Group {
            if let screen {
                switch screen {
                case .trips:
                    TripList3Column(selectedTrip: $selectedTrip)
                case .steps:
                    TripView()
                }
            } else {
                ContentUnavailableView("Select a Backyard", systemImage: "bird", description: Text("Pick something from the list."))
            }
        }
        #if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        #endif
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        AppContentColumn3(screen: .trips, selectedTrip: .constant(Trip.bedminsterToBeijing))
    }
}
