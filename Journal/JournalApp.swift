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
    
#if TEST
    let createContainer = false
#else
    let createContainer = true
#endif
    
    // https://m25lazi.medium.com/environment-variables-in-xcode-a78e07d223ed#:~:text=Choose%20Edit%20Scheme,above%20is%20for%20Run%20Configuration.
    
    
    var body: some Scene {
        let journalContainer = JournalDataContainer(inMemory: inMemory)
        
        WindowGroup {
            GeometryReader { geometry in
                ContentView()
                    .environment(\.sceneSize, geometry.size)
                    .environment(\.sceneAspectRatio, geometry.size.width / geometry.size.height)
            }
        }
        .modelContainer(journalContainer.container)
    }
}
