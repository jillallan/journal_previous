//
//  TripTests.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

final class TripTests: BaseTestCase {
    var testTrip: Trip!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
//        container = MockJournalDataContainer(inMemory: true)
//        modelContext = container.container.mainContext
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        
        // then
        XCTAssertNotEqual(testTrip.debugDescription, randomWord)
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
