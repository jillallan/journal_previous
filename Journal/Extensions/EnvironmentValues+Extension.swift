//
//  EnvironmentValues+Extension.swift
//  Journal
//
//  Created by Jill Allan on 29/09/2023.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
    
    var sceneSize: CGSize {
        get { self[SceneSize.self] }
        set { self[SceneSize.self] = newValue }
    }
    
    var sceneAspectRatio: Double {
        get { self[SceneAspectRatio.self] }
        set { self[SceneAspectRatio.self] = newValue }
    }
    
    var sceneAspectRatioClass: Double {
        get { self[SceneAspectRatio.self] }
        set { self[SceneAspectRatio.self] = newValue }
    }
}

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write.
    }
}
#endif

private struct SceneSize: EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

private struct SceneAspectRatio: EnvironmentKey {
    static let defaultValue: Double = 0.0
}

enum SceneRatioClassType {
    case square, portrait, wide, superwide
}

private struct SceneRatioClass: EnvironmentKey {
    static let defaultValue: SceneRatioClassType = .square
}
