//
//  LocationSearch.swift
//  Journal
//
//  Created by Jill Allan on 19/09/2023.
//

import MapKit
import OSLog
import SwiftUI

struct LocationSearch: View {
    // MARK: - Debugging
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )

    // MARK: - Search Service Properties
    @ObservedObject var mapSearchService = MapSearchService()
    @State var region: MKCoordinateRegion
    @State var searchQuery: String = ""

    // MARK: - Navigation Properties
    @State var isLocationSearchViewSearching: Bool = false
    @Binding var searchDetentsSize: PresentationDetent

    
    var body: some View {
        VStack {
            NavigationStack {
                SearchableView(isLocationSearchViewSearching: $isLocationSearchViewSearching, region: region)
            }
            .searchable(text: $searchQuery, prompt: "Search maps")
            .searchSuggestions {
                ForEach(mapSearchService.searchResults) { mapItem in
                    LocationSearchSuggestionRow(mapItem: mapItem)
//                    Text(mapItem.description)
                    //                            .searchCompletion(mapItem.placemark.title ?? "No placemark")
                }
            }
            .onChange(of: isLocationSearchViewSearching) {
                if isLocationSearchViewSearching {
                    searchDetentsSize = .large
                } else {
                    searchDetentsSize = .medium
                }
            }
            .onChange(of: searchQuery, debounceTime: 0.3) { searchQuery in
                Task {
                    await mapSearchService.search(for: searchQuery, in: region)
                }
            }
            .onSubmit(of: .search) {
                let _ = logger.debug("search submitted")
            }
        }        
    }
}

#Preview {
    NavigationStack {
        LocationSearch(
            region: MKCoordinateRegion(), searchDetentsSize: .constant(.medium)
        )
    }
}

struct SearchableView: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    @Binding var isLocationSearchViewSearching: Bool
    let region: MKCoordinateRegion
    
    @Environment(\.isSearching) var isSearching
    
    
    var body: some View {
        let _ = logger.debug("is searching: \(isSearching)")
        ScrollView {
            ScrollView(.horizontal) {
                
            }
        }
        .onChange(of: isSearching) {
            isLocationSearchViewSearching = isSearching
        }
        .navigationTitle("Region centre: \(region.center.latitude), \(region.center.longitude)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
