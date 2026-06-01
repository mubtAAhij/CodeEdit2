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
        CommandMenu(String(localized: "source-control-commands.menu", defaultValue: "Source Control", comment: "Source Control menu title")) {
            Group {
                Button(String(localized: "source-control-commands.commit", defaultValue: "Commit...", comment: "Command to commit changes")) {
                    // TODO: Open Source Control Navigator to Changes tab
                }
                .disabled(true)

                Button(String(localized: "source-control-commands.push", defaultValue: "Push...", comment: "Command to push changes")) {
                    sourceControlManager?.pushSheetIsPresented = true
                }

                Button(String(localized: "source-control-commands.pull", defaultValue: "Pull...", comment: "Command to pull changes")) {
                    sourceControlManager?.pullSheetIsPresented = true
                }
                .keyboardShortcut("x", modifiers: [.command, .option])

                Button(String(localized: "source-control-commands.fetch", defaultValue: "Fetch Changes", comment: "Command to fetch changes")) {
                    sourceControlManager?.fetchSheetIsPresented = true
                }

                Divider()

                Button(String(localized: "source-control-commands.stage-all", defaultValue: "Stage All Changes", comment: "Command to stage all changes")) {
                    guard let sourceControlManager else { return }
                    if sourceControlManager.changedFiles.isEmpty {
                        sourceControlManager.noChangesToStageAlertIsPresented = true
                    } else {
                        Task {
                            do {
                                try await sourceControlManager.add(sourceControlManager.changedFiles.map { $0.fileURL })
                            } catch {
                                await sourceControlManager.showAlertForError(
                                    title: String(localized: "source-control-commands.stage-error", defaultValue: "Failed To Stage Changes", comment: "Error title when staging fails"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Button(String(localized: "source-control-commands.unstage-all", defaultValue: "Unstage All Changes", comment: "Command to unstage all changes")) {
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
                                    title: String(localized: "source-control-commands.unstage-error", defaultValue: "Failed To Unstage Changes", comment: "Error title when unstaging fails"),
                                    error: error
                                )
                            }
                        }
                    }
                }

                Divider()

                Button(String(localized: "source-control-commands.cherry-pick", defaultValue: "Cherry-Pick...", comment: "Command to cherry-pick commits")) {
                    // TODO: Implementation Needed
                }
                .disabled(true)

                Button(String(localized: "source-control-commands.stash", defaultValue: "Stash Changes...", comment: "Command to stash changes")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToStashAlertIsPresented = true
                    } else {
                        sourceControlManager?.stashSheetIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "source-control-commands.discard-all", defaultValue: "Discard All Changes...", comment: "Command to discard all changes")) {
                    if sourceControlManager?.changedFiles.isEmpty ?? false {
                        sourceControlManager?.noChangesToDiscardAlertIsPresented = true
                    } else {
                        sourceControlManager?.discardAllAlertIsPresented = true
                    }
                }

                Divider()

                Button(String(localized: "source-control-commands.add-remote", defaultValue: "Add Exisiting Remote...", comment: "Command to add an existing remote")) {
                    sourceControlManager?.addExistingRemoteSheetIsPresented = true
                }
            }
            .disabled(windowController?.workspace == nil)
            .observeWindowController($windowController)
        }
    }
}
