//
//  JournalTests.swift
//  JournalTests
//
//  Created by Jill Allan on 01/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

class DataBaseTestCase: XCTestCase {
    var container: MockJournalDataContainer!
    var modelContext: ModelContext!
    
    @MainActor override func setUpWithError() throws {
        container = MockJournalDataContainer(inMemory: true)
        modelContext = container.container.mainContext
    }

    @MainActor override func tearDownWithError() throws {
        try deleteAllModels()
    }
    
    @MainActor func removeAllRelationships() throws {
        let activities = try container.container.mainContext.fetch(FetchDescriptor<Activity>())
        
        _ = activities.map { activity in
            activity.steps = []
            activity.suceedingActivity = nil
            activity.proceedingActivity = nil
        }
        
        let trips = try container.container.mainContext.fetch(FetchDescriptor<Trip>())
        
        _ = trips.map({ trip in
            trip.activities = []
        })
        
        let placemarks = try container.container.mainContext.fetch(FetchDescriptor<Placemark>())
        
        _ = placemarks.map({ placemark in
            placemark.steps = []
        })
    }
    
    @MainActor func deleteAllModels() throws {
        try removeAllRelationships()
        
        try container.container.mainContext.delete(model: Trip.self)
        try container.container.mainContext.delete(model: Activity.self)
        try container.container.mainContext.delete(model: Step.self)
        try container.container.mainContext.delete(model: Placemark.self)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
