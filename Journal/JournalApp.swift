//
//  JournalApp.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

@main
struct JournalApp: App {
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                ContentView()
                    .environment(\.sceneSize, geometry.size)
                    .environment(\.sceneAspectRatio, geometry.size.width / geometry.size.height)
            }
        }
        .modelContainer(for: Trip.self)
    }
}
