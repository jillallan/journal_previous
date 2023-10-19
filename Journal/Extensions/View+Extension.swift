//
//  View+Extension.swift
//  Journal
//
//  Created by Jill Allan on 17/09/2023.
//

import Combine
import SwiftUI

extension View {
    
    func journalDataContainer(inMemory: Bool = true) -> some View {
        modifier(JournalDataContainer(inMemory: inMemory))
    }
    
    func generateData() -> some View {
        modifier(GenerateDataViewModifier())
    }
    
    func scrollViewCardStyle(
        axes: Axis.Set,
        aspectRatio: Double,
        contentMode: ContentMode,
        cornerRadius: Double,
        count: Int,
        spacing: Double
    ) -> some View {
        modifier(ScrollViewCardStyle(
            axes: axes, 
            aspectRatio: aspectRatio,
            contentMode: contentMode,
            cornerRadius: cornerRadius,
            count: count,
            spacing: spacing
        ))
    }
    
    func onChange<Value>(
        of value: Value,
        debounceTime delayInterval: TimeInterval,
        perform action: @escaping (_ newValue: Value) -> Void
    ) -> some View where Value: Equatable {
        modifier(DebouncedChangeViewModifier(trigger: value, action: action) {
            try await Task.sleep(nanoseconds: UInt64(delayInterval * 1_000_000_000))
        })
    }
    
    // https://designcode.io/swiftui-handbook-conditional-modifier
    // https://www.avanderlee.com/swiftui/conditional-view-modifier/
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
         if condition {
             transform(self)
         } else {
             self
         }
     }
}

struct ScrollViewCardStyle: ViewModifier {
    var axes: Axis.Set
    var aspectRatio: Double
    var contentMode: ContentMode
    var cornerRadius: Double
    var count: Int
    var spacing: Double
    
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(aspectRatio, contentMode: contentMode)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
            .containerRelativeFrame(axes, count: count, spacing: spacing)
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
