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
    
    let activity: Activity
    @State private var activities: [Activity] = []
    @State private var scrollPositionID: PersistentIdentifier?
    
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
        .scrollPosition(id: $scrollPositionID)
        
        // MARK: - Navigation
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .time)
        }
        // TODO: Add navigation destination for journey activity to get to edit/add screen, or have an edit button
        
        // MARK: - View Updates
        .onAppear {
            activities.append(activity)
        }
        .onChange(of: scrollPositionID) {
            logger.debug("Scroll position ID: \(String(describing: scrollPositionID))")
        }
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            JourneyCard(activity: .templeMeadsToPaddington)
        }
    }
}
