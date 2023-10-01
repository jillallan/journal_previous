//
//  SidebarView.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftData
import SwiftUI

struct AppSidebar3Column: View {
    @Binding var selection: AppScreen3Column?
    
    var body: some View {
        
        List(AppScreen3Column.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
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
        .navigationTitle("Journal")
    }
}

#Preview {
    NavigationSplitView {
        AppSidebar3Column(selection: .constant(.trips))
    } content: {
        AppContentColumn3(screen: .trips, selectedTrip: .constant(Trip.bedminsterToBeijing))
    } detail: {
        Text(verbatim: "Detail view")
    }

}
