//
//  ProtocolTests.swift
//  JournalTests
//
//  Created by Jill Allan on 04/10/2023.
//

import XCTest
@testable import Journal

final class ProtocolTests: BaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJointThoroughfare() throws {
        let placemark = MockPlacemark(name: "Home", subThoroughfare: "138", thoroughfare: "High Street")
        
        XCTAssertEqual(placemark.jointThoroughfare, "138 High Street")
    }
    
    func testJointAdministrativeArea() throws {
        let placemark = MockPlacemark(subAdministrativeArea: "Bristol", administrativeArea: "England")
        
        XCTAssertEqual(placemark.jointAdministrativeArea, "Bristol, England")
    }
    
    func testJointLocality() throws {
        let placemark = MockPlacemark(subLocality: "Bedminster", locality: "Bristol")
        
        XCTAssertEqual(placemark.jointLocality, "Bedminster, Bristol")
    }
    
    func testLocalityAndAdminstrativeArea() throws {
        let placemark = MockPlacemark(subAdministrativeArea: "Bristol", administrativeArea: "England", subLocality: "Bedminster", locality: "Bristol")
        
        XCTAssertEqual(placemark.localityAndAdminstrativeArea, "Bedminster, Bristol, England")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
