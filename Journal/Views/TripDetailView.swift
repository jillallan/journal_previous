//
//  TripDetailView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    
    var body: some View {
        GeometryReader { geometry in
            Map()
                .safeAreaInset(edge: .bottom) {
                    TripActivityScrollView(trip: trip)
                        .frame(height: geometry.size.width / 1.5)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    }
}
