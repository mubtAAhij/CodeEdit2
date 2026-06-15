//
//  ViewCommands.swift
//  CodeEdit
//
//  Created by Wouter Hennen on 13/03/2023.
//

import SwiftUI
import Combine

struct ViewCommands: Commands {
    @AppSettings(\.textEditing.font.size)
    var editorFontSize
    @AppSettings(\.terminal.font.size)
    var terminalFontSize
    @AppSettings(\.general.showEditorJumpBar)
    var showEditorJumpBar
    @AppSettings(\.general.dimEditorsWithoutFocus)
    var dimEditorsWithoutFocus

    @FocusedBinding(\.navigationSplitViewVisibility)
    var navigationSplitViewVisibility

    @FocusedBinding(\.inspectorVisibility)
    var inspectorVisibility

    @UpdatingWindowController var windowController: CodeEditWindowController?

    var body: some Commands {
        CommandGroup(after: .toolbar) {
            Button(String(localized: "window-commands.view.show-command-palette", defaultValue: "Show Command Palette", comment: "Show command palette button")) {
                NSApp.sendAction(#selector(CodeEditWindowController.openCommandPalette(_:)), to: nil, from: nil)
            }
            .keyboardShortcut("p", modifiers: [.shift, .command])

            Button(String(localized: "window-commands.view.open-search-navigator", defaultValue: "Open Search Navigator", comment: "Open search navigator button")) {
                NSApp.sendAction(#selector(CodeEditWindowController.openSearchNavigator(_:)), to: nil, from: nil)
            }
            .keyboardShortcut("f", modifiers: [.shift, .command])

            Menu(String(localized: "window-commands.view.font-size", defaultValue: "Font Size", comment: "Font size menu")) {
                Button(String(localized: "window-commands.view.font-size-increase", defaultValue: "Increase", comment: "Increase font size button")) {
                    if editorFontSize < 288 {
                        editorFontSize += 1
                    }
                    if terminalFontSize < 288 {
                        terminalFontSize += 1
                    }
                }
                .keyboardShortcut("+")

                Button(String(localized: "window-commands.view.font-size-decrease", defaultValue: "Decrease", comment: "Decrease font size button")) {
                    if editorFontSize > 1 {
                        editorFontSize -= 1
                    }
                    if terminalFontSize > 1 {
                        terminalFontSize -= 1
                    }
                }
                .keyboardShortcut("-")

                Divider()

                Button(String(localized: "window-commands.view.font-size-reset", defaultValue: "Reset", comment: "Reset font size button")) {
                    editorFontSize = 12
                    terminalFontSize = 12
                }
                .keyboardShortcut("0", modifiers: [.command, .control])
            }
            .disabled(windowController == nil)

            Button(String(localized: "window-commands.view.customize-toolbar", defaultValue: "Customize Toolbar...", comment: "Customize toolbar button")) {

            }
            .disabled(true)

            Divider()

            HideCommands()

            Divider()

            Button(showEditorJumpBar ? String(localized: "window-commands.view.hide-jump-bar", defaultValue: "Hide Jump Bar", comment: "Hide jump bar button") : String(localized: "window-commands.view.show-jump-bar", defaultValue: "Show Jump Bar", comment: "Show jump bar button")) {
                showEditorJumpBar.toggle()
            }

            Toggle(String(localized: "window-commands.view.dim-editors-without-focus", defaultValue: "Dim editors without focus", comment: "Dim editors without focus toggle"), isOn: $dimEditorsWithoutFocus)

            Divider()

            if let model = windowController?.navigatorSidebarViewModel {
                Divider()
                NavigatorCommands(model: model)
            }
        }
    }
}

extension ViewCommands {
    struct HideCommands: View {
        @UpdatingWindowController var windowController: CodeEditWindowController?

        var navigatorCollapsed: Bool {
            windowController?.navigatorCollapsed ?? true
        }

        var inspectorCollapsed: Bool {
            windowController?.inspectorCollapsed ?? true
        }

        var utilityAreaCollapsed: Bool {
            windowController?.workspace?.utilityAreaModel?.isCollapsed ?? true
        }

        var toolbarCollapsed: Bool {
            windowController?.toolbarCollapsed ?? true
        }

        var isInterfaceHidden: Bool {
            return windowController?.isInterfaceStillHidden() ?? false
        }

        var body: some View {
            Button(navigatorCollapsed ? String(localized: "window-commands.view.show-navigator", defaultValue: "Show Navigator", comment: "Show navigator button") : String(localized: "window-commands.view.hide-navigator", defaultValue: "Hide Navigator", comment: "Hide navigator button")) {
                windowController?.toggleFirstPanel()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("0", modifiers: [.command])

            Button(inspectorCollapsed ? String(localized: "window-commands.view.show-inspector", defaultValue: "Show Inspector", comment: "Show inspector button") : String(localized: "window-commands.view.hide-inspector", defaultValue: "Hide Inspector", comment: "Hide inspector button")) {
                windowController?.toggleLastPanel()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("i", modifiers: [.control, .command])

            Button(utilityAreaCollapsed ? String(localized: "window-commands.view.show-utility-area", defaultValue: "Show Utility Area", comment: "Show utility area button") : String(localized: "window-commands.view.hide-utility-area", defaultValue: "Hide Utility Area", comment: "Hide utility area button")) {
                CommandManager.shared.executeCommand("open.drawer")
            }
            .disabled(windowController == nil)
            .keyboardShortcut("y", modifiers: [.shift, .command])

            Button(toolbarCollapsed ? String(localized: "window-commands.view.show-toolbar", defaultValue: "Show Toolbar", comment: "Show toolbar button") : String(localized: "window-commands.view.hide-toolbar", defaultValue: "Hide Toolbar", comment: "Hide toolbar button")) {
                windowController?.toggleToolbar()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("t", modifiers: [.option, .command])

            Button(isInterfaceHidden ? String(localized: "window-commands.view.show-interface", defaultValue: "Show Interface", comment: "Show interface button") : String(localized: "window-commands.view.hide-interface", defaultValue: "Hide Interface", comment: "Hide interface button")) {
                windowController?.toggleInterface(shouldHide: !isInterfaceHidden)
            }
            .disabled(windowController == nil)
            .keyboardShortcut("H", modifiers: [.shift, .command])
        }
    }
}

extension ViewCommands {
    struct NavigatorCommands: View {
        @ObservedObject var model: NavigatorAreaViewModel

        var body: some View {
            Menu(String(localized: "window-commands.view.navigators", defaultValue: "Navigators", comment: "Navigators menu"), content: {
                ForEach(Array(model.tabItems.prefix(9).enumerated()), id: \.element) { index, tab in
                    Button(tab.title) {
                        model.setNavigatorTab(tab: tab)
                    }
                    .keyboardShortcut(KeyEquivalent(Character(String(index + 1))))
                }
            })
        }
    }
}
