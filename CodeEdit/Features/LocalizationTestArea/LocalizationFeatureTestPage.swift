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

            Text(String(localized: "localization-test.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description explaining the purpose of this test page"))

            Group {
                TextField(String(localized: "localization-test.username-field", defaultValue: "Username", comment: "Placeholder for username text field"), text: $username)
                TextField(String(localized: "localization-test.email-field", defaultValue: "Email Address", comment: "Placeholder for email address text field"), text: $email)
                Button(String(localized: "localization-test.save-button", defaultValue: "Save Settings", comment: "Button to save user settings")) {}
                Button(String(localized: "localization-test.reset-button", defaultValue: "Reset to Defaults", comment: "Button to reset settings to default values")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Status message showing sync is connected"))
            Text(String(localized: "localization-test.backup-success", defaultValue: "Last backup completed successfully", comment: "Message indicating last backup succeeded"))
            Text(String(format: String(localized: "localization-test.projects-found", defaultValue: "Found %d recent projects", comment: "Message showing count of recent projects"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "Message indicating updates are available"))
            Text(String(localized: "localization-test.extension-load-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message when extensions fail to load"))

            HStack {
                Text(String(localized: "localization-test.quick-tip-label", defaultValue: "Quick tip:", comment: "Label for quick tip section"))
                Text(String(localized: "localization-test.quick-tip-text", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Tip explaining how to open command palette"))
            }

            Text(String(localized: "localization-test.delete-label", defaultValue: "Delete", comment: "Label for delete action"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message before deleting workspace"))
        }
        .padding()
    }
}
