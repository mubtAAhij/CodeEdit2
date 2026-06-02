//
//  SourceControlNavigatorNoRemotesView.swift
//  CodeEdit
//
//  Created by Austin Condiff on 11/17/23.
//

import SwiftUI

struct SourceControlNavigatorNoRemotesView: View {
    @EnvironmentObject var sourceControlManager: SourceControlManager

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Label(
                    title: {
                        Text(String(localized: "source-control-navigator.no-remotes", defaultValue: "No remotes", comment: "Label indicating the repository has no configured remote repositories"))
                    }, icon: {
                        Image(systemName: "network")
                            .foregroundColor(.secondary)
                    }
                )
                Spacer()
                Button(String(localized: "source-control-navigator.add-remote", defaultValue: "Add", comment: "Button to add a new remote repository")) {
                    sourceControlManager.addExistingRemoteSheetIsPresented = true
                }
            }
        }
    }
}
