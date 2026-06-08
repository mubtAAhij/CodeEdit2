//
//  PackageManagerError.swift
//  CodeEdit
//
//  Created by Abe Malla on 5/12/25.
//

import Foundation

enum PackageManagerError: Error, LocalizedError {
    case unknown
    case packageManagerNotInstalled
    case initializationFailed(String)
    case installationFailed(String)
    case invalidConfiguration

    var errorDescription: String? {
        switch self {
        case .unknown:
            String(localized: "lsp.package_manager.error.unknown", defaultValue: "Unknown error occurred", comment: "Generic unknown error message")
        case .packageManagerNotInstalled:
            String(localized: "lsp.package_manager.error.not_installed", defaultValue: "The required package manager is not installed.", comment: "Error when package manager is not installed")
        case .initializationFailed:
            String(localized: "lsp.package_manager.error.initialization_failed", defaultValue: "Installation directory initialization failed.", comment: "Error when directory initialization fails")
        case .installationFailed:
            String(localized: "lsp.package_manager.error.installation_failed", defaultValue: "Package installation failed.", comment: "Error when package installation fails")
        case .invalidConfiguration:
            String(localized: "lsp.package_manager.error.invalid_configuration", defaultValue: "The package registry contained an invalid installation configuration.", comment: "Error when registry has invalid configuration")
        }
    }

    var failureReason: String? {
        switch self {
        case .unknown:
            nil
        case .packageManagerNotInstalled:
            nil
        case .initializationFailed(let string):
            string
        case .installationFailed(let string):
            string
        case .invalidConfiguration:
            nil
        }
    }
}
