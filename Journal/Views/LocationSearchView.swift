//
//  LocationSearchView.swift
//  Journal
//
//  Created by Jill Allan on 19/09/2023.
//

import MapKit
import OSLog
import SwiftUI

struct LocationSearchView: View {
    @State var searchText: String = ""
    @State var searchResults: [MKMapItem] = []
    @State var searchBoxIsPresented: Bool = true
    @Binding var isLocationSearchViewSearching: Bool
    
    var body: some View {
            
        VStack {
            NavigationStack {
                SearchableView(isLocationSearchViewSearching: $isLocationSearchViewSearching)
            }
            .searchable(text: $searchText)
            .searchSuggestions {
                ForEach(searchResults, id: \.self) { mapItem in
                    Text(mapItem.placemark.title ?? "No placemark")
                    //                            .searchCompletion(mapItem.placemark.title ?? "No placemark")
                }
                
            }
            
        }
        .onChange(of: searchText) {
            
            // TODO: Add cancel() to stop search if search box empty
            // or isSearching modifier
            let searchRequest = MKLocalSearch.Request()
            searchRequest.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
            searchRequest.naturalLanguageQuery = searchText
            let search = MKLocalSearch(request: searchRequest)
            Task {
                do {
                    let searchResponse = try await search.start()
                    searchResults = searchResponse.mapItems
                } catch {
                    print("Unable to perform search result: \(error.localizedDescription)")
                }
                
            }
//            search.start { response, error in
//                guard let response = response else {
//                    if let error = error {
//                        print("Error getting search \(error.localizedDescription)")
//                    }
//                    return
//                }
//                searchResults.append(contentsOf: response.mapItems)
//            }
        }
        
        
    }
    
    func search() {
        
    }
}

#Preview {
    LocationSearchView(isLocationSearchViewSearching: .constant(false))
}

struct SearchableView: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    @Binding var isLocationSearchViewSearching: Bool
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
    }
}
