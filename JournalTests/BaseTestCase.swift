//
//  JournalTests.swift
//  JournalTests
//
//  Created by Jill Allan on 01/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

class BaseTestCase: XCTestCase {
    var container: MockJournalDataContainer!
    var modelContext: ModelContext!
    
    @MainActor override func setUpWithError() throws {
        container = MockJournalDataContainer(inMemory: true)
        modelContext = container.container.mainContext
    }

    override func tearDownWithError() throws {
        
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
