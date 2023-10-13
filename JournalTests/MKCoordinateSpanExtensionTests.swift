//
//  MKCoordinateSpanExtensionTests.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import MapKit
import XCTest
@testable import Journal

final class MKCoordinateSpanExtensionTests: BaseTestCase {
    
    func testCLLocationCoordinate2D_equatable_shouldReturnTrueWhenCoordinatesAreTheSame() {
        // if
        let randomLatitudeDelta = Double.random(in: -90...90)
        let randomLongitudeDelta = Double.random(in: -180...180)
        
        let lhsSpan = MKCoordinateSpan(latitudeDelta: randomLatitudeDelta, longitudeDelta: randomLongitudeDelta)
        
        // when
        let rhsSpan = MKCoordinateSpan(latitudeDelta: randomLatitudeDelta, longitudeDelta: randomLongitudeDelta)
        
        // then
        XCTAssertEqual(lhsSpan, rhsSpan, "Matching coordinates should match")
    }
    
    func testCLLocationCoordinate2D_equatable_shouldReturnFalseWhenCoordinatesAreTheNotTheSame() {
        // if
        let latitudeDelta = Double.random(in: -50...50)
        let longitudeDelta = Double.random(in: -150...150)
        let adjustment = Double.random(in: 1...10)
        
        let testArray = [
            [latitudeDelta, longitudeDelta, (latitudeDelta + adjustment), (longitudeDelta + adjustment), "Latitude and longitude deltas are both different"],
            [latitudeDelta, longitudeDelta, (latitudeDelta + adjustment), longitudeDelta, "Latitude delta is different"],
            [latitudeDelta, longitudeDelta, latitudeDelta, (longitudeDelta + adjustment), "Longitude delta is different"],
        ]
        
        for test in testArray {
            // when
            let lhs = MKCoordinateSpan(latitudeDelta: test[0] as! CLLocationDegrees, longitudeDelta: test[1] as! CLLocationDegrees)
            let rhs = MKCoordinateSpan(latitudeDelta: test[2] as! CLLocationDegrees, longitudeDelta: test[2] as! CLLocationDegrees)
            
            XCTAssertNotEqual(lhs, rhs, test[4] as! String)
        }
    }

    func testMKCoordinateSpan_spanOf_returnsRangeOfLatAndLong() {
        // if
        let coordinates = (0..<10).map { _ in
            CLLocationCoordinate2D.random()
        }
        
        let latitudeRange = coordinates.map(\.latitude).max()! - coordinates.map(\.latitude).min()!
        let longitudeRange = coordinates.map(\.longitude).max()! - coordinates.map(\.longitude).min()!
    
        // when
        let span = MKCoordinateSpan.span(of: coordinates)
        
        // then
        XCTAssertEqual(span, MKCoordinateSpan(latitudeDelta: latitudeRange, longitudeDelta: longitudeRange), "The span should be the range of the min and max of latitude and longitude")
        
    }
    
    
    func testMKCoordinateSpan_spanOfOneCoordinate_returnsRangeOfLatAndLong() {
        // if
        let coordinates = (0..<1).map { _ in
            CLLocationCoordinate2D.random()
        }
        
        XCTAssertEqual(coordinates.count, 1, "coordinate array should have count of 1, not \(coordinates.count)")
        
        let latitudeRange = coordinates.map(\.latitude).max()! - coordinates.map(\.latitude).min()!
        let longitudeRange = coordinates.map(\.longitude).max()! - coordinates.map(\.longitude).min()!
    
        // when
        let span = MKCoordinateSpan.span(of: coordinates)
        
        // then
        XCTAssertEqual(span, MKCoordinateSpan(latitudeDelta: latitudeRange, longitudeDelta: longitudeRange), "The span should be the range of the min and max of latitude and longitude")
        
    }

}
