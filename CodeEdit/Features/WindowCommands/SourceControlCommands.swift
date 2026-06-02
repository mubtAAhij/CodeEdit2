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
        CommandMenu(String(localized: "source-control-commands.menu", defaultValue: "Source Control", comment: "Source Control menu in menu bar")) {
            Group {
                Button(String(localized: "source-control-commands.commit", defaultValue: "Commit...", comment: "Button to commit changes")) {
                    // TODO: Open Source Control Navigator to Changes tab
                }
                .disabled(true)

                Button(String(localized: "source-control-commands.push", defaultValue: "Push...", comment: "Button to push changes to remote")) {
                    sourceControlManager?.pushSheetIsPresented = true
                }

                Button(String(localized: "source-control-commands.pull", defaultValue: "Pull...", comment: "Button to pull changes from remote")) {
                    sourceControlManager?.pullSheetIsPresented = true
                }
                .keyboardShortcut("x", modifiers: [.command, .option])

                Button(String(localized: "source-control-commands.fetch-changes", defaultValue: "Fetch Changes", comment: "Button to fetch changes from remote")) {
                    sourceControlManager?.fetchSheetIsPresented = true
                }

                Divider()

                Button(String(localized: "source-control-commands.stage-all-changes", defaultValue: "Stage All Changes", comment: "Button to stage all changes")) {
                    guard let sourceControlManager else { return }
                    if sourceControlManager.changedFiles.isEmpty {
                        sourceControlManager.noChangesToStageAlertIsPresented = true
                    } else {
                        Task {
                            do {
                                try await sourceControlManager.add(sourceControlManager.changedFiles.map { $0.fileURL })
                            } catch {
                                await sourceControlManager.showAlertForError(
                                    title: String(localized: "source-control-commands.failed-to-stage-changes", defaultValue: "Failed To Stage Changes", comment: "Error alert title when staging changes fails"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Button(String(localized: "source-control-commands.unstage-all-changes", defaultValue: "Unstage All Changes", comment: "Button to unstage all changes")) {
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
                                    title: String(localized: "source-control-commands.failed-to-unstage-changes", defaultValue: "Failed To Unstage Changes", comment: "Error alert title when unstaging changes fails"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Divider()

                Button(String(localized: "source-control-commands.cherry-pick", defaultValue: "Cherry-Pick...", comment: "Button to cherry-pick commits")) {
                    // TODO: Implementation Needed
                }
                .disabled(true)

                Button(String(localized: "source-control-commands.stash-changes", defaultValue: "Stash Changes...", comment: "Button to stash changes")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToStashAlertIsPresented = true
                    } else {
                        sourceControlManager?.stashSheetIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "source-control-commands.discard-all-changes", defaultValue: "Discard All Changes...", comment: "Button to discard all changes")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToDiscardAlertIsPresented = true
                    } else {
                        sourceControlManager?.discardAllAlertIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "source-control-commands.add-existing-remote", defaultValue: "Add Exisiting Remote...", comment: "Button to add existing remote")) {
                    sourceControlManager?.addExistingRemoteSheetIsPresented = true
                }
            }
            .disabled(windowController?.workspace == nil)
            .observeWindowController($windowController)
        }
    }
}
