//
//  JournalDataContainer.swift
//  Journal
//
//  Created by Jill Allan on 02/10/2023.
//

import SwiftData
import SwiftUI

struct JournalDataContainerViewModifier: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
    }
    
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
                DataGeneration.generateData(modelContext: modelContext)
            }
    }
}

extension View {
    func journalDataContainer(inMemory: Bool) -> some View {
        modifier(JournalDataContainerViewModifier(inMemory: inMemory))
    }
    
    func generateData() -> some View {
        modifier(GenerateDataViewModifier())
    }
}
