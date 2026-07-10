import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test.title", defaultValue: "Localization Feature Test Area", comment: "Title for the localization feature test page"))
                .font(.title2)

            Text(String(localized: "localization-test.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description for the localization feature test page"))

            Group {
                TextField(String(localized: "localization-test.username-field", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test.email-field", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test.save-button", defaultValue: "Save Settings", comment: "Save settings button")) {}
                Button(String(localized: "localization-test.reset-button", defaultValue: "Reset to Defaults", comment: "Reset to defaults button")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Sync status message"))
            Text(String(localized: "localization-test.backup-status", defaultValue: "Last backup completed successfully", comment: "Last backup status message"))
            Text(String(format: String(localized: "localization-test.projects-found", defaultValue: "%#@projects@", comment: "Number of recent projects found"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "New updates notification"))
            Text(String(localized: "localization-test.extensions-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message for failed extensions load"))

            HStack {
                Text(String(localized: "localization-test.quick-tip", defaultValue: "Quick tip:", comment: "Quick tip label"))
                Text(String(localized: "localization-test.command-palette-tip", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Command palette keyboard shortcut tip"))
            }

            Text(String(localized: "localization-test.delete-button", defaultValue: "Delete", comment: "Delete action button"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for workspace deletion"))
        }
        .padding()
    }
}
