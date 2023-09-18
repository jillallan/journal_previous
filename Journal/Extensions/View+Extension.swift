//
//  View+Extension.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import SwiftUI

extension View {
    func scrollViewCardStyle(
        aspectRatio: Double,
        cornerRadius: Double,
        count: Int,
        spacing: Double
    ) -> some View {
        modifier(ScrollViewCardStyle(
            aspectRatio: aspectRatio,
            cornerRadius: cornerRadius,
            count: count,
            spacing: spacing
        ))
    }
}

struct ScrollViewCardStyle: ViewModifier {
    var aspectRatio: Double
    var cornerRadius: Double
    var count: Int
    var spacing: Double
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
            .containerRelativeFrame([.horizontal], count: count, spacing: spacing)
    }
}
