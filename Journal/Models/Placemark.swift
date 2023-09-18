//
//  Placemark.swift
//  Journal
//
//  Created by Jill Allan on 18/09/2023.
//

import CoreLocation
import Foundation
import SwiftData

@Model
final class Placemark {
    
    // MARK: - Properties
    var latitude: Double
    var longitude: Double
    var name: String
    var subThoroughfare: String?
    var thoroughfare: String?
    var subAdministrativeArea: String?
    var administrativeArea: String?
    var subLocality: String?
    var locality: String?
    var postalCode: String?
    var country: String?
    var isoCountryCode: String?
    var inlandWater: String?
    var ocean: String?
    var areaOfInterest: String?
    var createdDate: Date
    
    // MARK: - Relationships
    var steps: [Step]? = []
    
    // MARK: - Computed Properties
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // MARK: - Initialization
    init(latitude: Double, longitude: Double, name: String, subThoroughfare: String? = nil, thoroughfare: String? = nil, subAdministrativeArea: String? = nil, administrativeArea: String? = nil, subLocality: String? = nil, locality: String? = nil, postalCode: String? = nil, country: String? = nil, isoCountryCode: String? = nil, inlandWater: String? = nil, ocean: String? = nil, areaOfInterest: String? = nil, createdDate: Date) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.subThoroughfare = subThoroughfare
        self.thoroughfare = thoroughfare
        self.subAdministrativeArea = subAdministrativeArea
        self.administrativeArea = administrativeArea
        self.subLocality = subLocality
        self.locality = locality
        self.postalCode = postalCode
        self.country = country
        self.isoCountryCode = isoCountryCode
        self.inlandWater = inlandWater
        self.ocean = ocean
        self.areaOfInterest = areaOfInterest
        self.createdDate = createdDate
    }
}

extension Placemark {
    static let templeMeadsStation = Placemark(
        latitude: 51.449667,
        longitude: -2.583172,
        name: "Temple Meads Station",
        createdDate: Date.now
    )
    
    static let bathSpaStation = Placemark(
        latitude: 51.377827,
        longitude: -2.356904,
        name: "Bath Spa Station",
        createdDate: Date.now
    )
    
    static let chippenhamStation = Placemark(
        latitude: 51.462365,
        longitude: -2.115312,
        name: "Chippenham Station",
        createdDate: Date.now
    )
    
    static let swindonStation = Placemark(
        latitude: 51.565890,
        longitude: -1.7855841,
        name: "Swindon Station",
        createdDate: Date.now
    )
    
    static let didcotStation = Placemark(
        latitude: 51.611101,
        longitude: -1.2427116,
        name: "Didoct Station",
        createdDate: Date.now
    )
    
    static let readingStation = Placemark(
        latitude: 51.458524,
        longitude: -0.9714477,
        name: "Reading Station",
        createdDate: Date.now
    )
    
    static let paddingtonStation = Placemark(
        latitude: 51.516725,
        longitude: -0.177346,
        name: "Paddington Station",
        createdDate: Date.now
    )
}
