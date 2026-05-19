//
//  ExtensionManagerWindow.swift
//  CodeEdit
//
//  Created by Wouter Hennen on 24/03/2023.
//

import SwiftUI

struct ExtensionManagerWindow: Scene {
    @ObservedObject var manager = ExtensionManager.shared

    @State var selection = Set<ExtensionInfo>()

    var body: some Scene {
        Window(String(localized: "extensions.window.title", defaultValue: "Extensions", comment: "Title for Extensions window"), id: SceneID.extensions.rawValue) {
            NavigationSplitView {
                ExtensionsListView(selection: $selection)
            } detail: {
                switch selection.count {
                case 0:
                    Text(String(localized: "extensions.detail.select-prompt", defaultValue: "Select an extension", comment: "Prompt to select an extension"))
                case 1:
                    ExtensionDetailView(ext: selection.first!)
                default:
                    Text(String(format: String(localized: "extensions.detail.selected-count", defaultValue: "%d selected", comment: "Number of extensions selected"), selection.count))
                }
            }
            .environmentObject(manager)
            .focusedObject(manager)
        }
    }
}
