//
//  TestDataContainer.swift
//  JournalTests
//
//  Created by Jill Allan on 03/10/2023.
//

import Foundation
import SwiftData
@testable import Journal

struct TestDataContainer {
    let container: ModelContainer
    var dataGeneration: DataGeneration.Type = DataGeneration.self
    
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
            print(String(describing: container))
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
    }
}
