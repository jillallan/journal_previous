//
//  JournalDataContainer.swift
//  Journal
//
//  Created by Jill Allan on 02/10/2023.
//

import SwiftData
import SwiftUI

// TODO: Do not create data when testing
struct JournalDataContainer {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
        
        print("Container initialized")
    }
}

extension JournalDataContainer: ViewModifier {
    // TODO: Remove generate data from here and add to JournalApp
    func body(content: Content) -> some View {
        content
            .generateData()
            .modelContainer(container)
    }
}

struct GenerateDataViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                SampleGeneration.generateData(modelContext: modelContext)
            }
    }
}

