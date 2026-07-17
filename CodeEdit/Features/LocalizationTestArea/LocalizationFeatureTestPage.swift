import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test.title", defaultValue: "Localization Feature Test Area", comment: "Title of the localization test page"))
                .font(.title2)

            Text(String(localized: "localization-test.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of the localization test page purpose"))

            Group {
                TextField(String(localized: "localization-test.username", defaultValue: "Username", comment: "Username field placeholder"), text: $username)
                TextField(String(localized: "localization-test.email", defaultValue: "Email Address", comment: "Email address field placeholder"), text: $email)
                Button(String(localized: "localization-test.save-settings", defaultValue: "Save Settings", comment: "Save button label")) {}
                Button(String(localized: "localization-test.reset-defaults", defaultValue: "Reset to Defaults", comment: "Reset button label")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Sync status message"))
            Text(String(localized: "localization-test.backup-success", defaultValue: "Last backup completed successfully", comment: "Backup completion message"))
            Text(String(format: String(localized: "localization-test.projects-found", defaultValue: "Found %d recent projects", comment: "Number of projects found"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "Updates notification message"))
            Text(String(localized: "localization-test.extensions-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Extensions loading error message"))

            HStack {
                Text(String(localized: "localization-test.quick-tip", defaultValue: "Quick tip:", comment: "Quick tip label"))
                Text(String(localized: "localization-test.command-palette-tip", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Command palette keyboard shortcut tip"))
            }

            Text(String(localized: "localization-test.delete", defaultValue: "Delete", comment: "Delete action label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Workspace deletion confirmation message"))
        }
        .padding()
    }
}
