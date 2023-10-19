//
//  ActivityCard.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftUI

struct ActivityCard: View {
    let activity: Activity
    
    var body: some View {
        Image(.mice)
            .resizable()
            .scaledToFill()
            .overlay {
                VStack {
                    Text(activity.startDate.formatted(date: .abbreviated, time: .shortened))
                    Text(activity.trip?.title ?? "No title")
                }
                .font(.largeTitle)
                .foregroundStyle(.white)
            }
            
    }
}

#Preview {
    ModelPreview { (model: Activity) in
        ActivityCard(activity: .paddington)
    }
}
