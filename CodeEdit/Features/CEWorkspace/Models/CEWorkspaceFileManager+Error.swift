//
//  CEWorkspaceFileManager+Error.swift
//  CodeEdit
//
//  Created by Khan Winter on 1/13/25.
//

import Foundation

extension CEWorkspaceFileManager {
    /// Localized errors related to actions in the file manager.
    /// These errors are suitable for presentation using `NSAlert(error:)`.
    enum FileManagerError: LocalizedError {
        case fileNotFound
        case fileNotIndexed
        case originFileNotFound
        case destinationFileExists
        case invalidFileName

        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return String(localized: "workspace.error.file-not-found", defaultValue: "File not found", comment: "Error message when a file cannot be found")
            case .fileNotIndexed:
                return String(localized: "workspace.error.file-not-found-in-codeedit", defaultValue: "File not found in CodeEdit", comment: "Error message when a file is not found in the CodeEdit workspace")
            case .originFileNotFound:
                return String(localized: "workspace.error.origin-file-not-found", defaultValue: "Failed to find origin file", comment: "Error message when the source file for an operation cannot be found")
            case .destinationFileExists:
                return String(localized: "workspace.error.destination-exists", defaultValue: "Destination already exists", comment: "Error message when trying to create or move a file to a location that already exists")
            case .invalidFileName:
                return String(localized: "workspace.error.invalid-filename", defaultValue: "Invalid file name", comment: "Error message when a file name is invalid")
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .fileNotIndexed:
                return String(localized: "workspace.error.recovery-reopen", defaultValue: "Reopen the workspace to reindex the file system.", comment: "Recovery suggestion to reopen the workspace")
            case .fileNotFound, .originFileNotFound:
                return String(localized: "workspace.error.recovery-retry", defaultValue: "The file may have moved during the operation, try again.", comment: "Recovery suggestion to retry the operation")
            case .destinationFileExists:
                return String(localized: "workspace.error.recovery-rename", defaultValue: "Use a different file name or remove the conflicting file.", comment: "Recovery suggestion to use a different name or remove conflicting file")
            case .invalidFileName:
                return String(localized: "workspace.error.recovery-filename-rules", defaultValue: "File names must not contain the : character and be less than 256 characters.", comment: "Recovery suggestion explaining file name rules")
            }
        }
    }
}
