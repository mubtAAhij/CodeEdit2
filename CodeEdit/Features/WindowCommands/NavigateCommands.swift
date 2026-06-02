//
//  NavigateCommands.swift
//  CodeEdit
//
//  Created by Wouter Hennen on 13/03/2023.
//

import SwiftUI

struct NavigateCommands: Commands {

    @UpdatingWindowController var windowController: CodeEditWindowController?
    private var editor: Editor? {
        windowController?.workspace?.editorManager?.activeEditor
    }

    var body: some Commands {
        CommandMenu(String(localized: "navigate-commands.menu-title", defaultValue: "Navigate", comment: "Navigate menu title")) {
            Group {
                Button(String(localized: "navigate-commands.reveal-in-navigator-button", defaultValue: "Reveal in Project Navigator", comment: "Button to reveal current file in project navigator")) {
                    NSApp.sendAction(#selector(ProjectNavigatorViewController.revealFile(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("j", modifiers: [.shift, .command])

                Button(String(localized: "navigate-commands.reveal-changes-button", defaultValue: "Reveal Changes in Navigator", comment: "Button to reveal changes in source control navigator")) {

                }
                .keyboardShortcut("m", modifiers: [.shift, .command])
                .disabled(true)

                Button(String(localized: "navigate-commands.open-in-next-editor-button", defaultValue: "Open in Next Editor", comment: "Button to open file in next editor pane")) {

                }
                .keyboardShortcut(",", modifiers: [.option, .command])
                .disabled(true)

                Button(String(localized: "navigate-commands.open-in-button", defaultValue: "Open in...", comment: "Button to open file in specific editor")) {

                }
                .disabled(true)

                Divider()

            }
            Group {
                Button(String(localized: "navigate-commands.show-previous-tab-button", defaultValue: "Show Previous Tab", comment: "Button to show previous editor tab")) {
                    editor?.selectPreviousTab()
                }
                .keyboardShortcut("{", modifiers: [.command])
                .disabled(editor?.tabs.count ?? 0 <= 1)  // Disable if there's one or no tabs

                Button(String(localized: "navigate-commands.show-next-tab-button", defaultValue: "Show Next Tab", comment: "Button to show next editor tab")) {
                    editor?.selectNextTab()
                }
                .keyboardShortcut("}", modifiers: [.command])
                .disabled(editor?.tabs.count ?? 0 <= 1)  // Disable if there's one or no tabs
            }
            Group {
                Divider()

                Button(String(localized: "navigate-commands.go-forward-button", defaultValue: "Go Forward", comment: "Button to go forward in navigation history")) {
                    editor?.goForwardInHistory()
                }
                .disabled(!(editor?.canGoForwardInHistory ?? false))

                Button(String(localized: "navigate-commands.go-back-button", defaultValue: "Go Back", comment: "Button to go back in navigation history")) {
                    editor?.goBackInHistory()
                }
                .disabled(!(editor?.canGoBackInHistory ?? false))
            }
            .disabled(editor == nil)
        }
    }
}
