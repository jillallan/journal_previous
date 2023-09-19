//
//  PersistenceHelper.swift
//  Journal
//
//  Created by Jill Allan on 18/09/2023.
//

import Foundation
import OSLog
import SwiftData

struct PersistenceHelper {
    
    static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    // TODO: Replace all with generic function
    
    static func getTrip(scrollPositionID: PersistentIdentifier, modelContext: ModelContext) -> Trip? {
        let predicate = #Predicate<Trip> { $0.persistentModelID == scrollPositionID }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        
        do {
            if let trip = try modelContext.fetch(fetchDescriptor).first {
                return trip
            }
        } catch {
            logger.error("Failed to fetch trip: \(error.localizedDescription)")
            // TODO: Deal with failure
        }
        return nil
    }
    
    static func getActivity(scrollPositionID: PersistentIdentifier, modelContext: ModelContext) -> Activity? {
        let predicate = #Predicate<Activity> { $0.persistentModelID == scrollPositionID }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        
        do {
            if let activity = try modelContext.fetch(fetchDescriptor).first {
                return activity
            }
        } catch {
            logger.error("Failed to fetch activity: \(error.localizedDescription)")
            // TODO: Deal with failure
        }
        return nil
    }
    
    static func getStep(scrollPositionID: PersistentIdentifier, modelContext: ModelContext) -> Step? {
        let predicate = #Predicate<Step> { $0.persistentModelID == scrollPositionID }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        
        do {
            if let step = try modelContext.fetch(fetchDescriptor).first {
                return step
            }
        } catch {
            logger.error("Failed to fetch step: \(error.localizedDescription)")
            // TODO: Deal with failure
        }
        return nil
    }
}
