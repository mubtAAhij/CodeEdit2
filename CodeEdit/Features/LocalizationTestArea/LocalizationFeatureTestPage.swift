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
                TextField(String(localized: "localization-test.username-field", defaultValue: "Username", comment: "Placeholder for username field"), text: $username)
                TextField(String(localized: "localization-test.email-field", defaultValue: "Email Address", comment: "Placeholder for email field"), text: $email)
                Button(String(localized: "localization-test.save-button", defaultValue: "Save Settings", comment: "Save settings button")) {}
                Button(String(localized: "localization-test.reset-button", defaultValue: "Reset to Defaults", comment: "Reset to defaults button")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Sync status message"))
            Text(String(localized: "localization-test.backup-status", defaultValue: "Last backup completed successfully", comment: "Backup completion message"))
            Text(String(format: String(localized: "localization-test.project-count", defaultValue: "%d recent projects", comment: "Number of recent projects found"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "Message indicating updates are available"))
            Text(String(localized: "localization-test.extension-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message for extension loading failure"))

            HStack {
                Text(String(localized: "localization-test.quick-tip-label", defaultValue: "Quick tip:", comment: "Label for quick tip section"))
                Text(String(localized: "localization-test.quick-tip-text", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Quick tip instructional text"))
            }

            Text(String(localized: "localization-test.delete-button", defaultValue: "Delete", comment: "Delete button"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Delete confirmation message"))
        }
        .padding()
    }
}
