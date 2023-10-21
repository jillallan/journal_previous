//
//  DataGenerationTests.swift
//  JournalTests
//
//  Created by Jill Allan on 03/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

final class JournalDataContainerTests: DataBaseTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor func testDataGeneration() throws {
//        let
        
        container.dataGeneration.generateData(modelContext: container.container.mainContext)
        let descriptor = FetchDescriptor<Trip>()
        let trips = try container.container.mainContext.fetchCount(descriptor)
       
        XCTAssertEqual(trips, 2)
    }
    
    @MainActor func testDataIsEmpty() throws {

        let descriptor = FetchDescriptor<Trip>()
        let trips = try container.container.mainContext.fetchCount(descriptor)
       
        XCTAssertEqual(trips, 0)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
