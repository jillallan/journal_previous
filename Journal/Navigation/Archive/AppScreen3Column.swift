//
//  AppScreen.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftUI

enum AppScreen3Column: Codable, Hashable, Identifiable, CaseIterable {
    case trips
    case steps

    
    var id: AppScreen3Column { self }
}

//extension AppScreen {
//    @ViewBuilder
//    var label: some View {
//        switch self {
//        case .trips:
//            Label("Trips", systemImage: "airplane")
//        case .steps:
//            Label("Steps", systemImage: "bird")
//            
//        }
//    }
//    
//    @ViewBuilder
//    var destination: some View {
//        switch self {
//        case .trips:
//            TripList3Column()
//        case .steps:
//            TripView()
//        }
//    }
//}

