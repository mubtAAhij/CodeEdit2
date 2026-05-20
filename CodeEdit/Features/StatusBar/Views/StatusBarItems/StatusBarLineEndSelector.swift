//
//  StatusBarLineEndSelector.swift
//  CodeEditModules/StatusBar
//
//  Created by Lukas Pistrol on 22.03.22.
//

import SwiftUI

struct StatusBarLineEndSelector: View {

    var body: some View {
        Menu {
            // LF, CRLF
        } label: {
            Text(String(localized: "status-bar.line-ending.lf", defaultValue: "LF", comment: "Label for LF (Line Feed) line ending in status bar"))
        }
        .menuStyle(StatusBarMenuStyle())
        .onHover { isHovering($0) }
    }
}
