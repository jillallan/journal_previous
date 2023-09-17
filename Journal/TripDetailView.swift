//
//  TripDetailView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    
    var body: some View {
        List {
            ForEach(trip.activities ?? []) { activity in
                NavigationLink(value: activity) {
                    Text(activity.startDate, style: .time)
                }
            }
        }
        .navigationDestination(for: Activity.self) { activity in
            ActivityView(activity: activity)
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    }
}
