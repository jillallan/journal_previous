//
//  TripEditor.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import SwiftUI

struct TripEditor: View {
    @State private var title: String = "New trip"
    
    var body: some View {
        
        Image(.mice)
            .resizable()
            .scaledToFill()
            .navigationTitle(title)
    }
}

#Preview {
    ModelContainerPreview(PreviewContainer.sample) {
        TripEditor()
    }
}
