//
//  LocationSearchView.swift
//  Journal
//
//  Created by Jill Allan on 19/09/2023.
//

import MapKit
import SwiftUI

struct LocationSearchView: View {
    @State var searchText: String = ""
    @State var searchResults: [MKMapItem] = []
    @State var searchBoxIsPresented: Bool = true
    
    var body: some View {
        VStack {
            Map()
            NavigationStack {
                ScrollView {
                    ScrollView(.horizontal) {
                        
                    }
                }
            }
            .searchable(text: $searchText, isPresented: .constant(true))
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
            searchRequest.naturalLanguageQuery = searchText
            let search = MKLocalSearch(request: searchRequest)
            Task {
                do {
                    let searchResponse = try await search.start()
                    _ = searchResponse.mapItems.map { mapItem in
                        searchResults.append(mapItem)
                    }
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
    LocationSearchView()
}
