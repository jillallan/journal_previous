//
//  CLPacemark+TestExtension.swift
//  JournalTests
//
//  Created by Jill Allan on 04/10/2023.
//

import CoreLocation
import Foundation
@testable import Journal

class MockPlacemark: PlacemarkDescribable {
    var name: String?
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
    
    init(name: String? = nil, subThoroughfare: String? = nil, thoroughfare: String? = nil, subAdministrativeArea: String? = nil, administrativeArea: String? = nil, subLocality: String? = nil, locality: String? = nil, postalCode: String? = nil, country: String? = nil, isoCountryCode: String? = nil, inlandWater: String? = nil, ocean: String? = nil, areaOfInterest: String? = nil) {
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
    }
    
}
