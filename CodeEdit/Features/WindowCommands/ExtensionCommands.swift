//
//  ExtensionCommands.swift
//  CodeEdit
//
//  Created by Wouter Hennen on 24/03/2023.
//

import SwiftUI
import CodeEditKit

struct ExtensionCommands: Commands {
    @FocusedObject var manager: ExtensionManager?

    @Environment(\.openWindow)
    var openWindow

    var body: some Commands {
        CommandMenu(String(localized: "window-commands.extensions-menu", defaultValue: "Extensions", comment: "Extensions menu in the menu bar")) {
            Button(String(localized: "window-commands.open-extensions-window", defaultValue: "Open Extensions Window", comment: "Command to open the extensions management window")) {
                openWindow(sceneID: .extensions)
            }
        }
    }
}
