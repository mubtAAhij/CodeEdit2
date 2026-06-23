//
//  StatusBarIndentSelector.swift
//  CodeEditModules/StatusBar
//
//  Created by Lukas Pistrol on 22.03.22.
//

import SwiftUI

struct StatusBarIndentSelector: View {
    @AppSettings(\.textEditing.defaultTabWidth)
    var defaultTabWidth

    var body: some View {
        Menu {
            Button {} label: {
                Text(String(localized: "status-bar.use-tabs", defaultValue: "Use Tabs", comment: "Menu item to use tabs for indentation"))
            }.disabled(true)

            Button {} label: {
                Text(String(localized: "status-bar.use-spaces", defaultValue: "Use Spaces", comment: "Menu item to use spaces for indentation"))
            }.disabled(true)

            Divider()

            Picker(String(localized: "status-bar.tab-width", defaultValue: "Tab Width", comment: "Picker label for tab width"), selection: $defaultTabWidth) {
                ForEach(2..<9) { index in
                    Text(String(format: String(localized: "status-bar.spaces-count", defaultValue: "%d Spaces", comment: "Tab width option"), index))
                        .tag(index)
                }
            }
        } label: {
            Text(String(format: String(localized: "status-bar.spaces-count", defaultValue: "%d Spaces", comment: "Tab width option"), defaultTabWidth))
        }
        .menuStyle(StatusBarMenuStyle())
        .onHover { isHovering($0) }
    }
}
