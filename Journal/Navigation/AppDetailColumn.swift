//
//  AppDetailColumn.swift
//  Journal
//
//  Created by Jill Allan on 30/09/2023.
//

import SwiftUI

struct AppDetailColumn: View {
    var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView("Select a Trip", systemImage: "airplane", description: Text("Pick something from the list."))
            }
        }
        #if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        #endif
    }
}

#Preview {
    AppDetailColumn()
}
