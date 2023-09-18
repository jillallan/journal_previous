//
//  PreviewContainer.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import CoreLocation
import Foundation
import SwiftData

@MainActor
struct PreviewContainer {
    static var preview: ModelContainer = {
        let schema = Schema([Trip.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            insertSampleData(modelContext: container.mainContext)
            
            return container
        } catch {
            fatalError("error loading sample data: \(error.localizedDescription)")
        }
    }()
    
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Trip.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(Trip.bedminsterToBeijing)
        
        modelContext.insert(Activity.templeMeads)
        modelContext.insert(Activity.templeMeadsToPaddington)
        modelContext.insert(Activity.paddington)

        modelContext.insert(Step.templeMeadsStation)
        modelContext.insert(Step.bathSpaStation)
        modelContext.insert(Step.chippenhamStation)
        modelContext.insert(Step.swindonStation)
        modelContext.insert(Step.didcotStation)
        modelContext.insert(Step.readingStation)
        modelContext.insert(Step.paddingtonStation)
        
        modelContext.insert(Placemark.templeMeadsStation)
        modelContext.insert(Placemark.bathSpaStation)
        modelContext.insert(Placemark.chippenhamStation)
        modelContext.insert(Placemark.swindonStation)
        modelContext.insert(Placemark.didcotStation)
        modelContext.insert(Placemark.readingStation)
        modelContext.insert(Placemark.paddingtonStation)

        Activity.templeMeads.trip = Trip.bedminsterToBeijing
        Activity.templeMeadsToPaddington.trip = Trip.bedminsterToBeijing
        Activity.paddington.trip = Trip.bedminsterToBeijing
        
        Activity.templeMeads.suceedingActivity = Activity.templeMeadsToPaddington
        Activity.templeMeadsToPaddington.suceedingActivity = Activity.paddington

        Step.templeMeadsStation.activity = Activity.templeMeads
        Step.bathSpaStation.activity = Activity.templeMeadsToPaddington
        Step.chippenhamStation.activity = Activity.templeMeadsToPaddington
        Step.swindonStation.activity = Activity.templeMeadsToPaddington
        Step.didcotStation.activity = Activity.templeMeadsToPaddington
        Step.readingStation.activity = Activity.templeMeadsToPaddington
        Step.paddingtonStation.activity = Activity.paddington
        
        Step.templeMeadsStation.placemark = Placemark.templeMeadsStation
        Step.bathSpaStation.placemark = Placemark.bathSpaStation
        Step.chippenhamStation.placemark = Placemark.chippenhamStation
        Step.swindonStation.placemark = Placemark.swindonStation
        Step.didcotStation.placemark = Placemark.didcotStation
        Step.readingStation.placemark = Placemark.readingStation
        Step.paddingtonStation.placemark = Placemark.paddingtonStation
    
    }
}

