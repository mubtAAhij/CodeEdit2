import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test-page.title", defaultValue: "Localization Feature Test Area", comment: "Title of the localization test page"))
                .font(.title2)

            Text(String(localized: "localization-test-page.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of the localization test page purpose"))

            Group {
                TextField(String(localized: "localization-test-page.username-field", defaultValue: "Username", comment: "Placeholder for username text field"), text: $username)
                TextField(String(localized: "localization-test-page.email-field", defaultValue: "Email Address", comment: "Placeholder for email text field"), text: $email)
                Button(String(localized: "localization-test-page.save-button", defaultValue: "Save Settings", comment: "Button to save settings")) {}
                Button(String(localized: "localization-test-page.reset-button", defaultValue: "Reset to Defaults", comment: "Button to reset to default settings")) {}
            }

            Divider()

            Text(String(localized: "localization-test-page.sync-status", defaultValue: "Sync status: Connected", comment: "Status message showing sync connection"))
            Text(String(localized: "localization-test-page.backup-status", defaultValue: "Last backup completed successfully", comment: "Status message for successful backup"))
            Text(String(format: String(localized: "localization-test-page.projects-found", defaultValue: "Found %d recent projects", comment: "Message showing number of projects found (dynamic count)"), projectCount))
            Text(String(localized: "localization-test-page.updates-available", defaultValue: "New updates are available", comment: "Message indicating new updates are available"))
            Text(String(localized: "localization-test-page.extensions-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message when extensions fail to load"))

            HStack {
                Text(String(localized: "localization-test-page.quick-tip-label", defaultValue: "Quick tip:", comment: "Label introducing a tip for the user"))
                Text(String(localized: "localization-test-page.quick-tip-content", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Tip content about opening command palette"))
            }

            Text(String(localized: "localization-test-page.delete-action", defaultValue: "Delete", comment: "Delete action label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test-page.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for deleting workspace"))
        }
        .padding()
    }
}
