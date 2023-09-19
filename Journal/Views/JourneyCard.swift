//
//  JourneyCard.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import OSLog
import SwiftData
import SwiftUI

struct JourneyCard: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    @Environment(\.modelContext) private var modelContext
    let activity: Activity
    @State private var activities: [Activity] = []
    @Binding var tripActivityScrollPositionID: PersistentIdentifier?
    @Binding var mapActivityID: PersistentIdentifier?
    @State var journeyScrollPositionID: PersistentIdentifier?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(activities) { activity in
                    Section {
                        ForEach(activity.activitySteps) { step in
                            NavigationLink(value: step) {
                                JourneyStepRow(step: step)
                            }
                        }
                    } header: {
                        Text(activity.startDate.formatted(date: .abbreviated, time: .shortened))
                            .padding(50)
                    } footer: {
                        Text("Add step")
                            .padding(100)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .background(.regularMaterial)
        .scrollViewCardStyle(aspectRatio: 1.5, cornerRadius: 25.0, count: 1, spacing: 10)
        .scrollPosition(id: $journeyScrollPositionID)
        
        // MARK: - Navigation
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .time)
        }
        // TODO: Add navigation destination for journey activity to get to edit/add screen, or have an edit button
        
        // MARK: - View Updates
        .onAppear {
            activities.append(activity)
        }
        .onChange(of: journeyScrollPositionID) {
            
            if tripActivityScrollPositionID == activity.persistentModelID {
                mapActivityID = journeyScrollPositionID
            }
        }
    }
}

#Preview("Visit") {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            JourneyCard(
                activity: .templeMeads,
                tripActivityScrollPositionID: .constant(Activity.templeMeads.persistentModelID),
                mapActivityID: .constant(Activity.templeMeads.persistentModelID)
            )
        }
    }
}

#Preview("Journey") {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            JourneyCard(
                activity: .templeMeadsToPaddington,
                tripActivityScrollPositionID: .constant(Activity.templeMeadsToPaddington.persistentModelID),
                mapActivityID: .constant(Activity.templeMeadsToPaddington.persistentModelID)
            )
        }
    }
}
