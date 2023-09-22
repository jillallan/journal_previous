//
//  View+Extension.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Combine
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
    
    
    // FIXME: Debounce isn't working
    func onChange<Value>(
        of value: Value,
        debounceTime delayInterval: TimeInterval,
//        debounceTime: Duration,
        perform action: @escaping (_ newValue: Value) -> Void
    ) -> some View where Value: Equatable {
        modifier(DebouncedChangeViewModifier(trigger: value, action: action) {
            try await Task.sleep(nanoseconds: UInt64(delayInterval * 1_000_000_000))
        })
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

// https://github.com/Tunous/DebouncedOnChange/blob/main/Sources/DebouncedOnChange/DebouncedChangeViewModifier.swift

struct DebouncedChangeViewModifier<Value>: ViewModifier where Value: Equatable {
    let trigger: Value
    let action: (Value) -> Void
    let sleep: @Sendable () async throws -> Void

    @State private var debouncedTask: Task<Void, Never>?

    func body(content: Content) -> some View {
        content.onChange(of: trigger) {
            debouncedTask?.cancel()
            debouncedTask = Task {
                do {
                    try await sleep()
                    action(trigger)
                } catch {
                    return
                }
            }
        }
    }
}
