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

    func testTrip_ChangeTitle_ChangesDebugDescription() {
        // if
        
        let title = String.randomWord()
        let startDate = Date.from(string: "2010-01-01", format: "yyyy-MM-dd")
        let endDate = Date.now
        
        let testTrip = Trip(title: title, startDate: startDate, endDate: endDate)
        let debugDescription = testTrip.debugDescription
        
        // when
        testTrip.title = String.randomWord()
        
        // then
        XCTAssertNotEqual(testTrip.debugDescription, debugDescription)
    }

}
