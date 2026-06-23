//
//  SourceControlCommands.swift
//  CodeEdit
//
//  Created by Austin Condiff on 6/29/24.
//

import SwiftUI

struct SourceControlCommands: Commands {
    @State private var windowController: CodeEditWindowController?

    @State private var confirmDiscardChanges: Bool = false

    var sourceControlManager: SourceControlManager? {
        windowController?.workspace?.sourceControlManager
    }

    var body: some Commands {
        CommandMenu(String(localized: "menu.source-control", defaultValue: "Source Control", comment: "Source Control menu")) {
            Group {
                Button(String(localized: "menu.source-control.commit", defaultValue: "Commit...", comment: "Commit menu item")) {
                    // TODO: Open Source Control Navigator to Changes tab
                }
                .disabled(true)

                Button(String(localized: "menu.source-control.push", defaultValue: "Push...", comment: "Push menu item")) {
                    sourceControlManager?.pushSheetIsPresented = true
                }

                Button(String(localized: "menu.source-control.pull", defaultValue: "Pull...", comment: "Pull menu item")) {
                    sourceControlManager?.pullSheetIsPresented = true
                }
                .keyboardShortcut("x", modifiers: [.command, .option])

                Button(String(localized: "menu.source-control.fetch-changes", defaultValue: "Fetch Changes", comment: "Fetch Changes menu item")) {
                    sourceControlManager?.fetchSheetIsPresented = true
                }

                Divider()

                Button(String(localized: "menu.source-control.stage-all", defaultValue: "Stage All Changes", comment: "Stage All Changes menu item")) {
                    guard let sourceControlManager else { return }
                    if sourceControlManager.changedFiles.isEmpty {
                        sourceControlManager.noChangesToStageAlertIsPresented = true
                    } else {
                        Task {
                            do {
                                try await sourceControlManager.add(sourceControlManager.changedFiles.map { $0.fileURL })
                            } catch {
                                await sourceControlManager.showAlertForError(
                                    title: String(localized: "source-control.error.stage-failed", defaultValue: "Failed To Stage Changes", comment: "Stage changes failed error"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Button(String(localized: "menu.source-control.unstage-all", defaultValue: "Unstage All Changes", comment: "Unstage All Changes menu item")) {
                    guard let sourceControlManager else { return }
                    if sourceControlManager.changedFiles.isEmpty {
                        sourceControlManager.noChangesToUnstageAlertIsPresented = true
                    } else {
                        Task {
                            do {
                                try await sourceControlManager.reset(
                                    sourceControlManager.changedFiles.map { $0.fileURL }
                                )
                            } catch {
                                await sourceControlManager.showAlertForError(
                                    title: String(localized: "source-control.error.unstage-failed", defaultValue: "Failed To Unstage Changes", comment: "Unstage changes failed error"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Divider()

                Button(String(localized: "menu.source-control.cherry-pick", defaultValue: "Cherry-Pick...", comment: "Cherry-Pick menu item")) {
                    // TODO: Implementation Needed
                }
                .disabled(true)

                Button(String(localized: "menu.source-control.stash-changes", defaultValue: "Stash Changes...", comment: "Stash Changes menu item")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToStashAlertIsPresented = true
                    } else {
                        sourceControlManager?.stashSheetIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "menu.source-control.discard-all", defaultValue: "Discard All Changes...", comment: "Discard All Changes menu item")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToDiscardAlertIsPresented = true
                    } else {
                        sourceControlManager?.discardAllAlertIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "menu.source-control.add-remote", defaultValue: "Add Existing Remote...", comment: "Add Existing Remote menu item")) {
                    sourceControlManager?.addExistingRemoteSheetIsPresented = true
                }
            }
            .disabled(windowController?.workspace == nil)
            .observeWindowController($windowController)
        }
    }
}
