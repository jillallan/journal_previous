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
            ContentView()
        }
        .modelContainer(for: Trip.self)
    }
}
