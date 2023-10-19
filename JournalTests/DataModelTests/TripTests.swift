//
//  TripTests.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

final class TripTests: DataBaseTestCase {
    var testTrip: Trip!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
//        container = MockJournalDataContainer(inMemory: true)
//        modelContext = container.container.mainContext
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
//        print("Deleted objects before tear down: \(modelContext.deletedModelsArray)")
//        // Put teardown code here. This method is called after the invocation of each test method in the class.

//        
//        print("Deleted objects after tear down: \(modelContext.deletedModelsArray)")
//        container.container.deleteAllData()
        
    }
    
    func testTrip_AddTrip_AddsTrip() throws {
        let descriptor = FetchDescriptor<Trip>()
        let trips = try modelContext.fetchCount(descriptor)
        
        XCTAssertEqual(trips, 0)
        
        modelContext.insert(Trip.bedminsterToBeijing)
        let tripsCount = try modelContext.fetchCount(descriptor)
        
        XCTAssertEqual(tripsCount, 1)
    }

    func testTrip_ChangeTitle_ChangesDebugDescription() {
        // if
        let trip = Trip.bedminsterToBeijing
        modelContext.insert(trip)
        
        let randomWord = String.randomWord()
        
        // when
        trip.title = randomWord
        let newDebugDescription = testTrip.debugDescription
        
        // then
        XCTAssertNotEqual(newDebugDescription, randomWord)
    }
    
    func testTrip_addActivities_changesTripActivities() throws {
        
        let trip = Trip.bedminsterToBeijing
        modelContext.insert(trip)
        
        let activity = Activity.templeMeads
        modelContext.insert(activity)
    
        activity.trip = trip

        XCTAssertEqual(trip.tripActivities.count, 1)
    }
    
    func testTrip_noActivities_returnsEmptyArray() throws {
        
        let trip = Trip.bedminsterToBeijing
        
        modelContext.insert(trip)

        XCTAssertEqual(trip.tripActivities.count, 0)
    
    }
    
    func testTrip_addSteps_changesTripSteps() {
        
    }

}
