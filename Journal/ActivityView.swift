//
//  ActivityView.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity
    
    var body: some View {
        if activity.activityType == .visit {
            Text(activity.startDate, style: .time)
        }
        
        if activity.activityType == .journey {
            List {
                ForEach(activity.steps ?? []) { step in
                    NavigationLink(value: step) {
                        Text(step.timestamp, style: .time)
                    }
                }
            }
            .navigationDestination(for: Step.self) { step in
                Text(step.timestamp, style: .time)
            }
        }
    }
}

#Preview("Visit") {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            ActivityView(activity: .templeMeads)
        }
    }
}

#Preview("Journey") {
    ModelContainerPreview(PreviewContainer.sample) {
        NavigationStack {
            ActivityView(activity: .templeMeadsToPaddington)
        }
    }
}
