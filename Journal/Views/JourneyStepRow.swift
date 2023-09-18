//
//  JourneyStepRow.swift
//  Journal
//
//  Created by Jill Allan on 18/09/2023.
//

import SwiftUI

struct JourneyStepRow: View {
    let step: Step
    
    var body: some View {
        HStack {
            Label("", systemImage: "arrow.forward")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                
                Text("170 yd")
                    .font(.headline)
                Text("Name")
                    .font(.subheadline)
                Divider()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        JourneyStepRow(step: .templeMeadsStation)
    }
}
