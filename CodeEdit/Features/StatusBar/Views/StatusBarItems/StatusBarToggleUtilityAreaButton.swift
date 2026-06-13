//
//  StatusBarToggleUtilityAreaButton.swift
//  CodeEdit
//
//  Created by Lukas Pistrol on 22.03.22.
//

import SwiftUI

internal struct StatusBarToggleUtilityAreaButton: View {
    @Environment(\.controlActiveState)
    var controlActiveState

    @EnvironmentObject private var utilityAreaViewModel: UtilityAreaViewModel

    internal var body: some View {
        Button {
            utilityAreaViewModel.togglePanel()
        } label: {
            Image(systemName: "square.bottomthird.inset.filled")
        }
        .buttonStyle(.icon)
        .keyboardShortcut("Y", modifiers: [.command, .shift])
        .help(utilityAreaViewModel.isCollapsed ? String(localized: "status-bar.utility.show", defaultValue: "Show the Utility area", comment: "Show Utility area tooltip") : String(localized: "status-bar.utility.hide", defaultValue: "Hide the Utility area", comment: "Hide Utility area tooltip"))
        .onHover { isHovering($0) }
        .onChange(of: controlActiveState) { _, newValue in
            if newValue == .key {
                CommandManager.shared.addCommand(
                    name: String(localized: "status-bar.utility.toggle-name", defaultValue: "Toggle Utility Area", comment: "Toggle Utility Area command name"),
                    title: String(localized: "status-bar.utility.toggle-title", defaultValue: "Toggle Utility Area", comment: "Toggle Utility Area command title"),
                    id: "open.drawer",
                    command: { [weak utilityAreaViewModel] in utilityAreaViewModel?.togglePanel() }
                )
            }
        }
        .onAppear {
            CommandManager.shared.addCommand(
                name: String(localized: "status-bar.utility.toggle-name", defaultValue: "Toggle Utility Area", comment: "Toggle Utility Area command name"),
                title: String(localized: "status-bar.utility.toggle-title", defaultValue: "Toggle Utility Area", comment: "Toggle Utility Area command title"),
                id: "open.drawer",
                command: { [weak utilityAreaViewModel] in utilityAreaViewModel?.togglePanel() }
            )
        }
    }
}
