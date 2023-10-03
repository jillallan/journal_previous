//
//  ExtensionTests.swift
//  JournalTests
//
//  Created by Jill Allan on 03/10/2023.
//

import XCTest
@testable import Journal

final class ExtensionTests: BaseTestCase {

    func testDateFormatter() throws {
        let dateString = "2016/07/28 08:06:00"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)
        
        let defaultDateFormat = DateFormatter.date(fromDefault: dateString)
        
        XCTAssertEqual(defaultDateFormat, date)
       
    }

    override func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
