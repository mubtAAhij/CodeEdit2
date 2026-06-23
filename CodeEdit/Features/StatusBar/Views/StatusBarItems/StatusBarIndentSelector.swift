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
                Text(String(localized: "status-bar.indent.use-tabs", defaultValue: "Use Tabs", comment: "Use Tabs button"))
            }.disabled(true)

            Button {} label: {
                Text(String(localized: "status-bar.indent.use-spaces", defaultValue: "Use Spaces", comment: "Use Spaces button"))
            }.disabled(true)

            Divider()

            Picker(String(localized: "status-bar.indent.tab-width", defaultValue: "Tab Width", comment: "Tab Width picker label"), selection: $defaultTabWidth) {
                ForEach(2..<9) { index in
                    Text(String(format: String(localized: "status-bar.indent.spaces-count", defaultValue: "%d Spaces", comment: "Number of spaces for indentation"), index))
                        .tag(index)
                }
            }
        } label: {
            Text(String(format: String(localized: "status-bar.indent.current-spaces", defaultValue: "%d Spaces", comment: "Current tab width in spaces"), defaultTabWidth))
        }
        .menuStyle(StatusBarMenuStyle())
        .onHover { isHovering($0) }
    }
}
