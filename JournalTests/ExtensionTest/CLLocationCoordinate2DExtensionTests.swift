//
//  CLLocationCoordinate2DExtensionTests.swift
//  JournalTests
//
//  Created by Jill Allan on 13/10/2023.
//

import CoreLocation
import XCTest
@testable import Journal

final class CLLocationCoordinate2DExtensionTests: XCTestCase {
    
    func testCLLocationCoordinate2D_equatable_shouldReturnTrueWhenCoordinatesAreTheSame() {
        // if
        let randomLatitude = Double.random(in: -90...90)
        let randomLongitude = Double.random(in: -180...180)
        
        let lhsCoordinate = CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
        
        // when
        let rhsCoordinate = CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
        
        // then
        XCTAssertEqual(lhsCoordinate, rhsCoordinate, "Matching coordinates should match")
    }
    
    func testCLLocationCoordinate2D_equatable_shouldReturnFalseWhenCoordinatesAreTheNotTheSame() {
        // if
        let latitude = Double.random(in: -50...50)
        let longitude = Double.random(in: -150...150)
        let adjustment = Double.random(in: 1...10)
        
        let testArray = [
            [latitude, longitude, (latitude + adjustment), (longitude + adjustment), "Latitude and longitude are both different"],
            [latitude, longitude, (latitude + adjustment), longitude, "Latitude is different"],
            [latitude, longitude, latitude, (longitude + adjustment), "Longitude is different"],
        ]
        
        for test in testArray {
            // when
            let lhs = CLLocationCoordinate2D(latitude: test[0] as! CLLocationDegrees, longitude: test[1] as! CLLocationDegrees)
            let rhs = CLLocationCoordinate2D(latitude: test[2] as! CLLocationDegrees, longitude: test[3] as! CLLocationDegrees)
            
            XCTAssertNotEqual(lhs, rhs, test[4] as! String)
        }
    }

    func testCLLocationCoordinate2D_random_generateACoordinate() {
        let testCoordinate = CLLocationCoordinate2D.random()
        
        XCTAssertTrue(testCoordinate.latitude.isNormal, "The coordinate latitude: \(testCoordinate.latitude) should be normal")
        XCTAssertTrue(testCoordinate.longitude.isNormal, "The coordinate longitude: \(testCoordinate.longitude) should be normal")
    }
    
    func testCLLocationCoordinate2D_getCentre_returnsMidRangeOfLatAndLong() {
        // if
        let coordinates = (0..<10).map { _ in
            CLLocationCoordinate2D.random()
        }
        
        let latitudeMidRange = (coordinates.map(\.latitude).min()!  + coordinates.map(\.latitude).max()!) / 2.0
        let longitudeMidRange = (coordinates.map(\.longitude).min()!  + coordinates.map(\.longitude).max()!) / 2.0
    
        // when
        let centre = CLLocationCoordinate2D.centre(of: coordinates)
        
        // then
        XCTAssertEqual(centre, CLLocationCoordinate2D(latitude: latitudeMidRange, longitude: longitudeMidRange), "The centre should be the midrange of the latitude and longitude")
        
    }
    
    func testCLLocationCoordinate2D_getCentreOfOneCoordinate_returnsMidRangeOfLatAndLong() {
        // if
        let coordinates = [CLLocationCoordinate2D.random()]
        
        XCTAssertEqual(coordinates.count, 1, "Coordinates count should be 1")
        
        
        let latitudeMidRange = (coordinates.map(\.latitude).min()!  + coordinates.map(\.latitude).max()!) / 2.0
        let longitudeMidRange = (coordinates.map(\.longitude).min()!  + coordinates.map(\.longitude).max()!) / 2.0
    
        // when
        let centre = CLLocationCoordinate2D.centre(of: coordinates)
        
        // then
        XCTAssertEqual(centre, CLLocationCoordinate2D(latitude: latitudeMidRange, longitude: longitudeMidRange), "The centre should be the midrange of the latitude and longitude")
    }

    func testCLLocationCoordinate2D_getCentreOfEmptyCoordinateArray_returnsNil() {
        // if
        let coordinates: [CLLocationCoordinate2D] = []
        
        XCTAssertEqual(coordinates.count, 0, "Coordinates count should be 0")
    
        // when
        let centre = CLLocationCoordinate2D.centre(of: coordinates)
        
        // then
        XCTAssertNil(centre, "Should return nil")
    }
    
}
