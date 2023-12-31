//
//  DetailView.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftUI

struct DetailView: View {
    let trip: Trip
    
    var body: some View {
        Text(trip.title)
    }
}

#Preview {
    ModelPreview { (model: Trip) in
        DetailView(trip: .bedminsterToBeijing)
    }
}
