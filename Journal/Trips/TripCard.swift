//
//  TripCard.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

struct TripCard: View {
    let trip: Trip
    
    var body: some View {
        Image(.mice)
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    Text(trip.title)
                        .font(.largeTitle)
                    Text(trip.startDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
            }
    }
}

#Preview {
    ModelPreview { (model: Trip) in
        TripCard(trip: .bedminsterToBeijing)
    }
}
