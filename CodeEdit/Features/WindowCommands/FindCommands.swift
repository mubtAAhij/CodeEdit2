//
//  FindCommands.swift
//  CodeEdit
//
//  Created by Wouter Hennen on 13/03/2023.
//

import SwiftUI

struct FindCommands: Commands {

    @FirstResponder var responder

    static let selector = #selector(NSTextView.performFindPanelAction(_:))

    var hasResponder: Bool {
        responder?.responds(to: Self.selector) ?? false
    }

    var body: some Commands {
        CommandMenu(String(localized: "find-commands.menu-title", defaultValue: "Find", comment: "Find menu title")) {
            Group {
                Button(String(localized: "find-commands.find-button", defaultValue: "Find...", comment: "Find menu item")) {
                    send(.showFindPanel)
                }
                .keyboardShortcut("f")

                Button(String(localized: "find-commands.find-replace-button", defaultValue: "Find and Replace...", comment: "Find and Replace menu item")) {
                    send(.init(rawValue: 12)!)
                }
                .keyboardShortcut("f", modifiers: [.option, .command])

                Button(String(localized: "find-commands.find-next-button", defaultValue: "Find Next", comment: "Find Next menu item")) {
                    send(.next)
                }
                .keyboardShortcut("g")

                Button(String(localized: "find-commands.find-previous-button", defaultValue: "Find Previous", comment: "Find Previous menu item")) {
                    send(.previous)
                }
                .keyboardShortcut("g", modifiers: [.shift, .command])

                Button(String(localized: "find-commands.use-selection-button", defaultValue: "Use Selection for Find", comment: "Use Selection for Find menu item")) {
                    send(.setFindString)
                }
                .keyboardShortcut("e")

                Button(String(localized: "find-commands.jump-to-selection-button", defaultValue: "Jump to Selection", comment: "Jump to Selection menu item")) {
                    NSApp.sendAction(#selector(NSTextView.centerSelectionInVisibleArea(_:)), to: nil, from: nil)
                }
                .keyboardShortcut("j")
            }
            .disabled(!hasResponder)
        }
    }

    func send(_ action: NSFindPanelAction) {
        let item = NSMenuItem()
        item.tag = Int(action.rawValue)
        responder?.perform(Self.selector, with: item)
    }
}
