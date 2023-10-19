//
//  AppSidebarList.swift
//  Journal
//
//  Created by Jill Allan on 30/09/2023.
//

import SwiftUI

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Journal")
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.trips))
    } detail: {
        Text(verbatim: "Detail View!")
    }
}
