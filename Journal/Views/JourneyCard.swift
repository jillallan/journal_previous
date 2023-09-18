//
//  JourneyCard.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

struct JourneyCard: View {
    let activity: Activity
    @State private var activities: [Activity] = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(activities) { activity in
                    Section {
                        ForEach(activity.steps ?? []) { step in
                            NavigationLink(value: step) {
                                JourneyStepRow(step: step)
                            }
                        }
                    } header: {
                        Text(activity.startDate.formatted(date: .abbreviated, time: .shortened))
                    } footer: {
                        Text("Add step")
                    }
                }
            }
        }
        .background(.regularMaterial)
        .scrollViewCardStyle(aspectRatio: 1.5, cornerRadius: 25.0, count: 1, spacing: 10)
        
        // MARK: - Navigation
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .time)
        }
        // TODO: Add navigation destination for journey activity to get to edit/add screen, or have an edit button
        
        // MARK: - View Updates
        .onAppear {
            activities.append(activity)
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
