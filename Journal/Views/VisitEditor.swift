//
//  VisitEditor.swift
//  Journal
//
//  Created by Jill Allan on 19/09/2023.
//

import MapKit
import SwiftUI

struct VisitEditor: View {
    let activity: Activity?
    @State var mapPosition: MapCameraPosition = .automatic
    @State var arrivalDate: Date
    @State var departureDate: Date
    @State private var isSearchViewPresented: Bool = false
    
    var body: some View {
        Map(position: $mapPosition) {
            // TODO: search results
        }
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
                .frame(height: 300)
            }
        }
        .sheet(isPresented: $isSearchViewPresented) {
            LocationSearchView()
        }
    }
}

#Preview("New visit") {
    VisitEditor(activity: nil, arrivalDate: Date.now, departureDate: Date.now)
}
