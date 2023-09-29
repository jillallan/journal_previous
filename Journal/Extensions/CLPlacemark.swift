//
//  CLPlacemark.swift
//  Journal
//
//  Created by Jill Allan on 22/09/2023.
//

import CoreLocation
import Foundation

enum PlacemarkDescriptionType {
case thoroughfare
    case areaOfInterest
    case name
    case locality
    case adminstrativeArea
    case country
    case other
}

extension CLPlacemark {
    var title: String {
        if let firstAreaOfInterest = areasOfInterest?.first {
            return firstAreaOfInterest
        } else if let name {
            return name
        } else if let inlandWater {
            return inlandWater
        } else if let ocean {
            return ocean
        } else if let jointThoroughfare {
            return jointThoroughfare
        } else if let jointLocality {
            return jointLocality
        } else if let jointAdministrativeArea {
            return jointAdministrativeArea
        } else if let country {
            return country
        }
        return "No name"
    }
    
    var titleType: PlacemarkDescriptionType {
        if areasOfInterest != nil {
            return .areaOfInterest
        } else if name != nil {
            return .name
        } else if inlandWater != nil {
            return .other
        } else if ocean != nil {
            return .other
        } else if jointThoroughfare != nil {
            return .thoroughfare
        } else if jointLocality != nil {
            return .locality
        } else if jointAdministrativeArea != nil {
            return .adminstrativeArea
        } else if country != nil {
            return .country
        }
        return .other
    }

    var jointThoroughfare: String? {
        if let subThoroughfare,
           let thoroughfare {
            return subThoroughfare + " " + thoroughfare
        } else if let thoroughfare {
            return thoroughfare
        }
        
        return nil
    }
    
    
    var jointLocality: String? {
        if let subLocality,
           let locality {
            if subLocality == locality {
                return locality
            } else {
                return subLocality + ", " + locality
            }
        } else if let locality {
            return locality
        }
        return nil
    }
    
    var jointAdministrativeArea: String? {
        if let subAdministrativeArea,
           let administrativeArea {
            if subAdministrativeArea == administrativeArea {
                return administrativeArea
            } else {
                return subAdministrativeArea + ", " + administrativeArea
            }
        } else if let administrativeArea {
            return administrativeArea
        }
        return nil
    }
    
    var localityAndAdminstrativeArea: String? {
        if let locality,
           let subAdministrativeArea {
            if locality == subAdministrativeArea {
                if let subLocality,
                   let administrativeArea {
                    return subLocality + ", " + locality + ", " + administrativeArea
                } else if let subLocality {
                    return subLocality + ", " + locality
                } else if let administrativeArea {
                    return locality + ", " + administrativeArea
                } else {
                    return locality
                }
            }
        } else if let jointLocality,
                  let jointAdministrativeArea {
            return jointLocality + ", " + jointAdministrativeArea
        } else if let jointLocality {
            return jointLocality
        } else if let jointAdministrativeArea {
            return jointAdministrativeArea
        }
        return nil
    }
    
    
    
    var subTitle: String {
        switch titleType {
        
        case .areaOfInterest, .name:
            if let jointThoroughfare,
               let jointLocality {
                return jointThoroughfare + ", " + jointLocality
            } else if let jointThoroughfare,
                      let jointAdministrativeArea {
                return jointThoroughfare + ", " + jointAdministrativeArea
            } else if let jointLocality,
                      let jointAdministrativeArea {
//                return localityAndAdminstrativeArea ?? ""
                return jointLocality + ", " + jointAdministrativeArea
            } else if let jointLocality,
                      let country {
                return jointLocality + ", " + country
            } else if let jointAdministrativeArea,
                      let country {
                return jointAdministrativeArea + ", " + country
            } else if let country {
                return country
            }
        case .thoroughfare:
            if let jointLocality {
                return jointLocality
            } else if let jointAdministrativeArea {
                return jointAdministrativeArea
            } else if let country {
                return country
            }
        case .locality:
            if let jointAdministrativeArea {
                return jointAdministrativeArea
            } else if let country {
                return country
            }
        case .adminstrativeArea:
            if let country {
                return country
            }
        case .country:
            return "Add continent"
        case .other:
            if let jointLocality {
                return jointLocality
            } else if let jointAdministrativeArea {
                return jointAdministrativeArea
            } else if let country {
                return country
            }
        }
        return "No details"
    }
}
