//
//  AppTabView3Column.swift
//  Journal
//
//  Created by Jill Allan on 30/09/2023.
//
//
import SwiftUI

struct AppTabView3Column: View {
    @Binding var selection: AppScreen3Column?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen3Column.allCases) { screen in
                Group {
                    switch screen {
                    case .trips:
                        TripList3Column(selectedTrip: .constant(nil))
                    case .steps:
                        TripView()
                    }
                }
                .tag(screen as AppScreen3Column?)
                .tabItem {
                    switch selection {
                    case .trips:
                        Label("Trips", systemImage: "airplane")
                    case .steps:
                        Label("Steps", systemImage: "bird")
                        
                    case .none:
                        Label("Steps", systemImage: "bird")
                    }
                }
            }
        }
    }
}

#Preview {
    AppTabView3Column(selection: .constant(nil))
}
