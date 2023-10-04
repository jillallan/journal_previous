//
//  DataGenerationTests.swift
//  JournalTests
//
//  Created by Jill Allan on 03/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

final class JournalDataContainerTests: BaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor func testDataGeneration2() throws {
        let container = MockJournalDataContainer(inMemory: true)
        
        container.dataGeneration.generateData(modelContext: container.container.mainContext)
        let descriptor = FetchDescriptor<Trip>()
        let trips = try container.container.mainContext.fetchCount(descriptor)
       
        XCTAssertEqual(trips, 2)

    }

    override func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
