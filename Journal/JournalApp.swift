//
//  JournalApp.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

@main
struct JournalApp: App {
  
#if DEBUG
    let inMemory: Bool = true
#else
    let inMemory: Bool = false
#endif
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                ContentView()
                    .journalDataContainer(inMemory: inMemory)
                    .environment(\.sceneSize, geometry.size)
                    .environment(\.sceneAspectRatio, geometry.size.width / geometry.size.height)
            }
        }
    }
}
