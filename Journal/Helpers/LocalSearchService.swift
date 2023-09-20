//
//  LocalSearchService.swift
//  Journal
//
//  Created by Jill Allan on 20/09/2023.
//

import MapKit
import SwiftUI

@Observable
class LocalSearchService {
    var searchText: String = ""
    var searchQuery = Debouncer(initialValue: "", delay: 3.0)
    var searchResults: [MKMapItem] = []
    
    init(region: MKCoordinateRegion) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = searchQuery.output
        let search = MKLocalSearch(request: searchRequest)
        Task { @MainActor in
            do {
                let searchResponse = try await search.start()
                self.searchResults = searchResponse.mapItems
            } catch {
                print("Unable to perform search result: \(error.localizedDescription)")
            }
        }
    }
}
