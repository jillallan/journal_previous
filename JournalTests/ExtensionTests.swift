//
//  ExtensionTests.swift
//  JournalTests
//
//  Created by Jill Allan on 03/10/2023.
//

import CoreLocation
import XCTest
@testable import Journal

final class ExtensionTests: BaseTestCase {

    func testDateString_whenFormatter() throws {
        // if
        let dateString = "2016/07/28 08:06:00"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)
        
        // when
        let defaultDateFormat = DateFormatter.date(fromDefault: dateString)
        
        // then
        XCTAssertEqual(defaultDateFormat, date)
       
    }
    

    
    func testCLLocationCoordinate2d_whenComparingMatchingCooridantes_returnsTrue() throws {
        let coordinate1 = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0)
        let coordinate2 = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0)
        
        XCTAssertTrue(coordinate1 == coordinate2)
    }
    
    func testCLLocationCoordinate2d_whenComparingMissmatchingCooridantes_returnsFalse() throws {
        let coordinate1 = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0)
        let coordinate2 = CLLocationCoordinate2D(latitude: 51.0, longitude: 1.0)
        
        XCTAssertTrue(coordinate1 != coordinate2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
