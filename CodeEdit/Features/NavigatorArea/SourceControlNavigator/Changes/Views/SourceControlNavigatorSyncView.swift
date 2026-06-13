//
//  SourceControlNavigatorSyncView.swift
//  CodeEdit
//
//  Created by Albert Vinizhanau on 10/20/23.
//

import SwiftUI

struct SourceControlNavigatorSyncView: View {
    @ObservedObject var sourceControlManager: SourceControlManager
    @State private var isLoading: Bool = false

    var body: some View {
        if let currentBranch = sourceControlManager.currentBranch {
            HStack {
                if currentBranch.upstream == nil {
                    Label(title: {
                        Text(String(format: String(localized: "source-control.sync.no-tracked-branch", defaultValue: "No tracked branch for '%@'", comment: "Message when branch has no tracked remote branch"), sourceControlManager.currentBranch?.name ?? ""))
                    }, icon: {
                        Image(symbol: "branch")
                            .foregroundStyle(.secondary)
                    })
                } else {
                    Label(title: {
                        Text(
                            formatUnsyncedlabel(
                                ahead: sourceControlManager.numberOfUnsyncedCommits.ahead,
                                behind: sourceControlManager.numberOfUnsyncedCommits.behind
                            )
                        )
                    }, icon: {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundStyle(.secondary)
                    })
                }

                Spacer()
                if sourceControlManager.numberOfUnsyncedCommits.behind > 0 {
                    Button {
                        sourceControlManager.pullSheetIsPresented = true
                    } label: {
                        Text(String(localized: "source-control.sync.pull", defaultValue: "Pull...", comment: "Button to pull changes from remote"))
                    }
                    .disabled(isLoading)
                } else if sourceControlManager.numberOfUnsyncedCommits.ahead > 0
                    || currentBranch.upstream == nil {
                    Button {
                        sourceControlManager.pushSheetIsPresented = true
                    } label: {
                        Text(String(localized: "source-control.sync.push", defaultValue: "Push...", comment: "Button to push changes to remote"))
                    }
                    .disabled(isLoading)
                }
            }
        }
    }

    func pull() {
        Task(priority: .background) {
            self.isLoading = true
            do {
                try await sourceControlManager.pull()
            } catch {
                await sourceControlManager.showAlertForError(title: String(localized: "source-control.sync.failed-pull", defaultValue: "Failed to pull", comment: "Error title when pull operation fails"), error: error)
            }
            self.isLoading = false
        }
    }

    func push() {
        Task(priority: .background) {
            self.isLoading = true
            do {
                try await sourceControlManager.push()
            } catch {
                await sourceControlManager.showAlertForError(title: String(localized: "source-control.sync.failed-push", defaultValue: "Failed to push", comment: "Error title when push operation fails"), error: error)
            }
            self.isLoading = false
        }
    }

    func formatUnsyncedlabel(ahead: Int?, behind: Int?) -> String {
        let aheadCount = ahead ?? 0
        let behindCount = behind ?? 0

        if aheadCount > 0 && behindCount > 0 {
            return String(format: String(localized: "source-control.sync.ahead-and-behind", defaultValue: "%d ahead, %d behind", comment: "Status showing commits ahead and behind remote"), aheadCount, behindCount)
        } else if aheadCount > 0 {
            return String(format: String(localized: "source-control.sync.ahead-only", defaultValue: "%d ahead", comment: "Status showing commits ahead of remote"), aheadCount)
        } else if behindCount > 0 {
            return String(format: String(localized: "source-control.sync.behind-only", defaultValue: "%d behind", comment: "Status showing commits behind remote"), behindCount)
        } else {
            return ""
        }
    }
}
