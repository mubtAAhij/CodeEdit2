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
                TextField(String(localized: "localization-test.username", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test.email", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test.save-settings", defaultValue: "Save Settings", comment: "Button to save settings")) {}
                Button(String(localized: "localization-test.reset-defaults", defaultValue: "Reset to Defaults", comment: "Button to reset settings to defaults")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Sync status message showing connected state"))
            Text(String(localized: "localization-test.backup-success", defaultValue: "Last backup completed successfully", comment: "Message indicating successful backup completion"))
            Text(String(format: String(localized: "localization-test.recent-projects", defaultValue: "Found %d recent projects", comment: "Message showing count of recent projects found"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "Message indicating new updates are available"))
            Text(String(localized: "localization-test.extensions-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message when extensions fail to load"))

            HStack {
                Text(String(localized: "localization-test.quick-tip", defaultValue: "Quick tip:", comment: "Label introducing a quick tip"))
                Text(String(localized: "localization-test.command-palette-tip", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Tip about opening the command palette"))
            }

            Text(String(localized: "localization-test.delete", defaultValue: "Delete", comment: "Delete action label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for workspace deletion"))
        }
        .padding()
    }
}
