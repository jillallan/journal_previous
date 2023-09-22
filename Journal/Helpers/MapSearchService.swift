//
//  LocalSearchService.swift
//  Journal
//
//  Created by Jill Allan on 20/09/2023.
//

import MapKit
import OSLog
import SwiftUI

class MapSearchService: ObservableObject {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MapSearchService.self)
    )
    
    @Published var searchQuery = Debouncer(initialValue: "", delay: 3.0)
    @Published var searchResults: [MKMapItem] = []
    
    @MainActor
    func search(for query: String, in region: MKCoordinateRegion) async {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query
        
        
        let search = MKLocalSearch(request: searchRequest)
        
        do {
            let searchResponse = try await search.start()
            self.searchResults = searchResponse.mapItems
        } catch {
            logger.error("Unable to perform search result: \(error.localizedDescription)")
        }
    }
}
