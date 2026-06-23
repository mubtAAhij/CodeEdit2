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
        CommandMenu(String(localized: "menu.source-control", defaultValue: "Source Control", comment: "Source Control menu title")) {
            Group {
                Button(String(localized: "menu.source-control.commit", defaultValue: "Commit...", comment: "Menu item to open commit interface")) {
                    // TODO: Open Source Control Navigator to Changes tab
                }
                .disabled(true)

                Button(String(localized: "menu.source-control.push", defaultValue: "Push...", comment: "Menu item to push changes to remote")) {
                    sourceControlManager?.pushSheetIsPresented = true
                }

                Button(String(localized: "menu.source-control.pull", defaultValue: "Pull...", comment: "Menu item to pull changes from remote")) {
                    sourceControlManager?.pullSheetIsPresented = true
                }
                .keyboardShortcut("x", modifiers: [.command, .option])

                Button(String(localized: "menu.source-control.fetch-changes", defaultValue: "Fetch Changes", comment: "Menu item to fetch changes from remote")) {
                    sourceControlManager?.fetchSheetIsPresented = true
                }

                Divider()

                Button(String(localized: "menu.source-control.stage-all-changes", defaultValue: "Stage All Changes", comment: "Menu item to stage all changed files")) {
                    guard let sourceControlManager else { return }
                    if sourceControlManager.changedFiles.isEmpty {
                        sourceControlManager.noChangesToStageAlertIsPresented = true
                    } else {
                        Task {
                            do {
                                try await sourceControlManager.add(sourceControlManager.changedFiles.map { $0.fileURL })
                            } catch {
                                await sourceControlManager.showAlertForError(
                                    title: String(localized: "source-control.error.failed-to-stage-changes", defaultValue: "Failed To Stage Changes", comment: "Error alert title when staging changes fails"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Button(String(localized: "menu.source-control.unstage-all-changes", defaultValue: "Unstage All Changes", comment: "Menu item to unstage all changed files")) {
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
                                    title: String(localized: "source-control.error.failed-to-unstage-changes", defaultValue: "Failed To Unstage Changes", comment: "Error alert title when unstaging changes fails"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Divider()

                Button(String(localized: "menu.source-control.cherry-pick", defaultValue: "Cherry-Pick...", comment: "Menu item to cherry-pick commits")) {
                    // TODO: Implementation Needed
                }
                .disabled(true)

                Button(String(localized: "menu.source-control.stash-changes", defaultValue: "Stash Changes...", comment: "Menu item to stash uncommitted changes")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToStashAlertIsPresented = true
                    } else {
                        sourceControlManager?.stashSheetIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "menu.source-control.discard-all-changes", defaultValue: "Discard All Changes...", comment: "Menu item to discard all uncommitted changes")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToDiscardAlertIsPresented = true
                    } else {
                        sourceControlManager?.discardAllAlertIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "menu.source-control.add-existing-remote", defaultValue: "Add Exisiting Remote...", comment: "Menu item to add an existing git remote")) {
                    sourceControlManager?.addExistingRemoteSheetIsPresented = true
                }
            }
            .disabled(windowController?.workspace == nil)
            .observeWindowController($windowController)
        }
    }
}
