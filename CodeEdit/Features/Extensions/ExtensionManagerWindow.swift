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
        Window(String(localized: "extension-manager.window-title", defaultValue: "Extensions", comment: "Extensions window title"), id: SceneID.extensions.rawValue) {
            NavigationSplitView {
                ExtensionsListView(selection: $selection)
            } detail: {
                switch selection.count {
                case 0:
                    Text(String(localized: "extension-manager.select-prompt", defaultValue: "Select an extension", comment: "Prompt shown when no extension is selected"))
                case 1:
                    ExtensionDetailView(ext: selection.first!)
                default:
                    Text(String(format: String(localized: "extension-manager.selection-count", defaultValue: "%d selected", comment: "Count of selected extensions"), selection.count))
                }
            }
            .environmentObject(manager)
            .focusedObject(manager)
        }
    }
}
