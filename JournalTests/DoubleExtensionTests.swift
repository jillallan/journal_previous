//
//  DoubleExtensionTests.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import XCTest
@testable import Journal

final class DoubleExtensionTests: BaseTestCase {

    func testDouble_getMidRange_returnsAverageOfMinimumAndMaximum() throws {
        // if
        let doublesArray = [-300.0, -1.5, 80.56, 100.32, 200.3, 300.0]
        
        // when
        let range = try XCTUnwrap(Double.range(of: doublesArray))
        
        // then
        XCTAssertEqual(range, 300 - (-300), "Range should be the difference between the min and max")
        
    }
    
    func testDouble_getMidRange_returnsAverageOfMinimumAndMaximum_Random() throws {
        // if
        let doublesArray = (0..<10).map { _ in
            Double.random(in: -100...100)
        }
        
        let maxMinusMin = doublesArray.max()! - doublesArray.min()!
        
        // when
        let range = try XCTUnwrap(Double.range(of: doublesArray))
        
        // then
        XCTAssertEqual(range, maxMinusMin, "Range should be the difference between the min and max")
    }

}
