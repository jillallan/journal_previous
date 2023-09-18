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
            VisitCard(activity: activity)
        }
        
        if activity.activityType == .journey {
            JourneyCard(activity: activity)
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
