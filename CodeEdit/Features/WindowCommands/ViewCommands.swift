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
            Button(String(localized: "view-commands.show-command-palette", defaultValue: "Show Command Palette", comment: "Button to show command palette")) {
                NSApp.sendAction(#selector(CodeEditWindowController.openCommandPalette(_:)), to: nil, from: nil)
            }
            .keyboardShortcut("p", modifiers: [.shift, .command])

            Button(String(localized: "view-commands.open-search-navigator", defaultValue: "Open Search Navigator", comment: "Button to open search navigator")) {
                NSApp.sendAction(#selector(CodeEditWindowController.openSearchNavigator(_:)), to: nil, from: nil)
            }
            .keyboardShortcut("f", modifiers: [.shift, .command])

            Menu(String(localized: "view-commands.font-size-menu", defaultValue: "Font Size", comment: "Menu for font size adjustments")) {
                Button(String(localized: "view-commands.font-size-increase", defaultValue: "Increase", comment: "Button to increase font size")) {
                    if editorFontSize < 288 {
                        editorFontSize += 1
                    }
                    if terminalFontSize < 288 {
                        terminalFontSize += 1
                    }
                }
                .keyboardShortcut("+")

                Button(String(localized: "view-commands.font-size-decrease", defaultValue: "Decrease", comment: "Button to decrease font size")) {
                    if editorFontSize > 1 {
                        editorFontSize -= 1
                    }
                    if terminalFontSize > 1 {
                        terminalFontSize -= 1
                    }
                }
                .keyboardShortcut("-")

                Divider()

                Button(String(localized: "view-commands.font-size-reset", defaultValue: "Reset", comment: "Button to reset font size")) {
                    editorFontSize = 12
                    terminalFontSize = 12
                }
                .keyboardShortcut("0", modifiers: [.command, .control])
            }
            .disabled(windowController == nil)

            Button(String(localized: "view-commands.customize-toolbar", defaultValue: "Customize Toolbar...", comment: "Button to customize toolbar")) {

            }
            .disabled(true)

            Divider()

            HideCommands()

            Divider()

            Button(showEditorJumpBar ? String(localized: "view-commands.hide-jump-bar", defaultValue: "Hide Jump Bar", comment: "Button to hide jump bar") : String(localized: "view-commands.show-jump-bar", defaultValue: "Show Jump Bar", comment: "Button to show jump bar")) {
                showEditorJumpBar.toggle()
            }

            Toggle(String(localized: "view-commands.dim-editors-toggle", defaultValue: "Dim editors without focus", comment: "Toggle to dim unfocused editors"), isOn: $dimEditorsWithoutFocus)

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
            Button(navigatorCollapsed ? String(localized: "view-commands.show-navigator", defaultValue: "Show Navigator", comment: "Button to show navigator") : String(localized: "view-commands.hide-navigator", defaultValue: "Hide Navigator", comment: "Button to hide navigator")) {
                windowController?.toggleFirstPanel()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("0", modifiers: [.command])

            Button(inspectorCollapsed ? String(localized: "view-commands.show-inspector", defaultValue: "Show Inspector", comment: "Button to show inspector") : String(localized: "view-commands.hide-inspector", defaultValue: "Hide Inspector", comment: "Button to hide inspector")) {
                windowController?.toggleLastPanel()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("i", modifiers: [.control, .command])

            Button(utilityAreaCollapsed ? String(localized: "view-commands.show-utility-area", defaultValue: "Show Utility Area", comment: "Button to show utility area") : String(localized: "view-commands.hide-utility-area", defaultValue: "Hide Utility Area", comment: "Button to hide utility area")) {
                CommandManager.shared.executeCommand("open.drawer")
            }
            .disabled(windowController == nil)
            .keyboardShortcut("y", modifiers: [.shift, .command])

            Button(toolbarCollapsed ? String(localized: "view-commands.show-toolbar", defaultValue: "Show Toolbar", comment: "Button to show toolbar") : String(localized: "view-commands.hide-toolbar", defaultValue: "Hide Toolbar", comment: "Button to hide toolbar")) {
                windowController?.toggleToolbar()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("t", modifiers: [.option, .command])

            Button(isInterfaceHidden ? String(localized: "view-commands.show-interface", defaultValue: "Show Interface", comment: "Button to show interface") : String(localized: "view-commands.hide-interface", defaultValue: "Hide Interface", comment: "Button to hide interface")) {
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
            Menu(String(localized: "view-commands.navigators-menu", defaultValue: "Navigators", comment: "Menu for navigator selection"), content: {
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
