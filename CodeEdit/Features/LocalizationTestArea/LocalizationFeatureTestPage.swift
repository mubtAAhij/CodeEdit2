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

            Text(String(localized: "localization-test.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of the localization test page"))

            Group {
                TextField(String(localized: "localization-test.username-field", defaultValue: "Username", comment: "Placeholder for username text field"), text: $username)
                TextField(String(localized: "localization-test.email-field", defaultValue: "Email Address", comment: "Placeholder for email text field"), text: $email)
                Button(String(localized: "localization-test.save-button", defaultValue: "Save Settings", comment: "Button to save settings")) {}
                Button(String(localized: "localization-test.reset-button", defaultValue: "Reset to Defaults", comment: "Button to reset settings to defaults")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Sync connection status message"))
            Text(String(localized: "localization-test.backup-success", defaultValue: "Last backup completed successfully", comment: "Backup completion message"))
            Text(String(format: String(localized: "localization-test.recent-projects", defaultValue: "Found %d recent projects", comment: "Message showing number of recent projects"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "Message about available updates"))
            Text(String(localized: "localization-test.extensions-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message for extension loading failure"))

            HStack {
                Text(String(localized: "localization-test.quick-tip-label", defaultValue: "Quick tip:", comment: "Label for quick tip section"))
                Text(String(localized: "localization-test.quick-tip-text", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Quick tip about command palette shortcut"))
            }

            Text(String(localized: "localization-test.delete-button", defaultValue: "Delete", comment: "Delete button label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for workspace deletion"))
        }
        .padding()
    }
}
