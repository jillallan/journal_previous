//
//  ActivityCard.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

struct VisitCard: View {
    let activity: Activity
    
    var body: some View {
        Image(.mice)
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    Text(activity.startDate.formatted(date: .abbreviated, time: .shortened))
                }
                .font(.largeTitle)
                .foregroundStyle(.white)
            }
            .scrollViewCardStyle(aspectRatio: 1.5, cornerRadius: 25.0, count: 1, spacing: 10)
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        VisitCard(activity: .paddington)
    }
}
