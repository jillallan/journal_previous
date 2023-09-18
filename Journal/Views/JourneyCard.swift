//
//  JourneyCard.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

struct JourneyCard: View {
    let activity: Activity
    
    var body: some View {
        List {
            ForEach(activity.steps ?? []) { step in
                NavigationLink(value: step) {
                    Text(step.timestamp, style: .time)
                }
            }
        }
        .scrollViewCardStyle(aspectRatio: 1.5, cornerRadius: 25.0, count: 1, spacing: 10)
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .time)
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
