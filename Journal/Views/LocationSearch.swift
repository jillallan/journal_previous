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
    @State var searchResult: MKMapItem?

    // MARK: - Navigation Properties
    @Binding var searchDetentsSize: PresentationDetent
//    @State var isSearchResultShowing: Bool = false

    var body: some View {
        VStack {
            NavigationStack {
                SearchableView(searchDetentsSize: $searchDetentsSize)
            }
#if os(iOS)
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search maps")
#endif
#if os(macOS)
            .searchable(text: $searchQuery, placement: .automatic, prompt: "Search maps")
#endif
            .searchSuggestions {
                ForEach(mapSearchService.searchResults) { mapItem in
                    LocationSearchSuggestionRow(mapItem: mapItem)
                        .onTapGesture {
                            logger.debug("item selected: \(mapItem.placemark.subTitle)")
                            searchDetentsSize = .medium
                            searchResult = mapItem
                        }
//                        .searchCompletion(mapItem.placemark.subTitle)
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
            .sheet(item: $searchResult) {
                searchDetentsSize = .large
            } content: { mapItem in
                LocationSearchSuggestionRow(mapItem: mapItem)
                    .presentationDetents(
                        [.medium, .large])
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
    @Binding var searchDetentsSize: PresentationDetent
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal) {
              
                
            }
        }
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .onChange(of: isSearching) {
            if isSearching {
                searchDetentsSize = .large
            } else {
                searchDetentsSize = .medium
            }
        }
    }
}
