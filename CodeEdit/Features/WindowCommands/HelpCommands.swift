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
            Button(String(localized: "help-commands.whats-new", defaultValue: "What's New in CodeEdit", comment: "Menu item to view what's new in the current version")) {

            }
            .disabled(true)

            Button(String(localized: "help-commands.release-notes", defaultValue: "Release Notes", comment: "Menu item to view release notes")) {
            }
            .disabled(true)

            Button(String(localized: "help-commands.report-issue", defaultValue: "Report an Issue", comment: "Menu item to report a bug or issue")) {
                NSApp.sendAction(#selector(AppDelegate.openFeedback(_:)), to: nil, from: nil)
            }
        }
    }
}
