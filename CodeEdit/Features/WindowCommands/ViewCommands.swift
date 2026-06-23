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
            Button(String(localized: "menu.view.show-command-palette", defaultValue: "Show Command Palette", comment: "Menu item to show command palette")) {
                NSApp.sendAction(#selector(CodeEditWindowController.openCommandPalette(_:)), to: nil, from: nil)
            }
            .keyboardShortcut("p", modifiers: [.shift, .command])

            Button(String(localized: "menu.view.open-search-navigator", defaultValue: "Open Search Navigator", comment: "Menu item to open search navigator")) {
                NSApp.sendAction(#selector(CodeEditWindowController.openSearchNavigator(_:)), to: nil, from: nil)
            }
            .keyboardShortcut("f", modifiers: [.shift, .command])

            Menu(String(localized: "menu.view.font-size", defaultValue: "Font Size", comment: "Font Size menu")) {
                Button(String(localized: "menu.view.font-size.increase", defaultValue: "Increase", comment: "Increase font size menu item")) {
                    if editorFontSize < 288 {
                        editorFontSize += 1
                    }
                    if terminalFontSize < 288 {
                        terminalFontSize += 1
                    }
                }
                .keyboardShortcut("+")

                Button(String(localized: "menu.view.font-size.decrease", defaultValue: "Decrease", comment: "Decrease font size menu item")) {
                    if editorFontSize > 1 {
                        editorFontSize -= 1
                    }
                    if terminalFontSize > 1 {
                        terminalFontSize -= 1
                    }
                }
                .keyboardShortcut("-")

                Divider()

                Button(String(localized: "menu.view.font-size.reset", defaultValue: "Reset", comment: "Reset font size menu item")) {
                    editorFontSize = 12
                    terminalFontSize = 12
                }
                .keyboardShortcut("0", modifiers: [.command, .control])
            }
            .disabled(windowController == nil)

            Button(String(localized: "menu.view.customize-toolbar", defaultValue: "Customize Toolbar...", comment: "Menu item to customize toolbar")) {

            }
            .disabled(true)

            Divider()

            HideCommands()

            Divider()

            Button(showEditorJumpBar ? String(localized: "view_commands.toggle_jump_bar.hide", defaultValue: "Hide Jump Bar", comment: "Menu item to hide jump bar") : String(localized: "view_commands.toggle_jump_bar.show", defaultValue: "Show Jump Bar", comment: "Menu item to show jump bar")) {
                showEditorJumpBar.toggle()
            }

            Toggle(String(localized: "menu.view.dim-editors-without-focus", defaultValue: "Dim editors without focus", comment: "Toggle to dim editors without focus"), isOn: $dimEditorsWithoutFocus)

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
            Button(navigatorCollapsed ? String(localized: "view_commands.toggle_navigator.show", defaultValue: "Show Navigator", comment: "Menu item to show navigator") : String(localized: "view_commands.toggle_navigator.hide", defaultValue: "Hide Navigator", comment: "Menu item to hide navigator")) {
                windowController?.toggleFirstPanel()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("0", modifiers: [.command])

            Button(inspectorCollapsed ? String(localized: "view_commands.toggle_inspector.show", defaultValue: "Show Inspector", comment: "Menu item to show inspector") : String(localized: "view_commands.toggle_inspector.hide", defaultValue: "Hide Inspector", comment: "Menu item to hide inspector")) {
                windowController?.toggleLastPanel()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("i", modifiers: [.control, .command])

            Button(utilityAreaCollapsed ? String(localized: "view_commands.toggle_utility_area.show", defaultValue: "Show Utility Area", comment: "Menu item to show utility area") : String(localized: "view_commands.toggle_utility_area.hide", defaultValue: "Hide Utility Area", comment: "Menu item to hide utility area")) {
                CommandManager.shared.executeCommand("open.drawer")
            }
            .disabled(windowController == nil)
            .keyboardShortcut("y", modifiers: [.shift, .command])

            Button(toolbarCollapsed ? String(localized: "view_commands.toggle_toolbar.show", defaultValue: "Show Toolbar", comment: "Menu item to show toolbar") : String(localized: "view_commands.toggle_toolbar.hide", defaultValue: "Hide Toolbar", comment: "Menu item to hide toolbar")) {
                windowController?.toggleToolbar()
            }
            .disabled(windowController == nil)
            .keyboardShortcut("t", modifiers: [.option, .command])

            Button(isInterfaceHidden ? String(localized: "view_commands.toggle_interface.show", defaultValue: "Show Interface", comment: "Menu item to show interface") : String(localized: "view_commands.toggle_interface.hide", defaultValue: "Hide Interface", comment: "Menu item to hide interface")) {
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
            Menu(String(localized: "menu.view.navigators", defaultValue: "Navigators", comment: "Navigators menu"), content: {
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
