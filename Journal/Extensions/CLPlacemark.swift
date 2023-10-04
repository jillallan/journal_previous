//
//  CLPlacemark.swift
//  Journal
//
//  Created by Jill Allan on 22/09/2023.
//

import CoreLocation
import Foundation

extension CLPlacemark: PlacemarkDescribable {
    
    var areaOfInterest: String? {
        if let areasOfInterest {
            return areasOfInterest.first
        } else {
            return nil
        }
    }
}
