//
//  AppTabView.swift
//  Journal
//
//  Created by Jill Allan on 30/09/2023.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        AppTabView(selection: .constant(.trips))
    }
}

