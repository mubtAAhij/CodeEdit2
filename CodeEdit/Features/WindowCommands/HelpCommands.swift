//
//  HelpCommands.swift
//  CodeEdit
//
//  Created by Wouter Hennen on 14/03/2023.
//

import SwiftUI

struct HelpCommands: Commands {
    var body: some Commands {
        CommandGroup(after: .help) {
            Button(String(localized: "help.whats-new", defaultValue: "What's New in CodeEdit", comment: "Help menu item to show what's new in this version")) {

            }
            .disabled(true)

            Button(String(localized: "help.release-notes", defaultValue: "Release Notes", comment: "Help menu item to show release notes")) {
            }
            .disabled(true)

            Button(String(localized: "help.report-issue", defaultValue: "Report an Issue", comment: "Help menu item to report a bug or issue")) {
                NSApp.sendAction(#selector(AppDelegate.openFeedback(_:)), to: nil, from: nil)
            }
        }
    }
}
