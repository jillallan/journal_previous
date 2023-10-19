//
//  ContentView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var selection: AppScreen? = .trips
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {

        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}


#Preview {
    ContentView()
        .journalDataContainer()
}
