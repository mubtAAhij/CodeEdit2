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
                TextField(String(localized: "localization-test.username-field", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test.email-field", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test.save-button", defaultValue: "Save Settings", comment: "Save settings button")) {}
                Button(String(localized: "localization-test.reset-button", defaultValue: "Reset to Defaults", comment: "Reset to defaults button")) {}
            }

            Divider()

            Text(String(localized: "localization-test.sync-status", defaultValue: "Sync status: Connected", comment: "Sync status message"))
            Text(String(localized: "localization-test.backup-status", defaultValue: "Last backup completed successfully", comment: "Backup completion message"))
            Text(String(format: String(localized: "localization-test.project-count", defaultValue: "Found %d recent projects", comment: "Number of recent projects found"), projectCount))
            Text(String(localized: "localization-test.updates-available", defaultValue: "New updates are available", comment: "Updates available notification"))
            Text(String(localized: "localization-test.extension-error", defaultValue: "Failed to load extensions. Please try again.", comment: "Extension loading error message"))

            HStack {
                Text(String(localized: "localization-test.quick-tip-label", defaultValue: "Quick tip:", comment: "Quick tip label"))
                Text(String(localized: "localization-test.quick-tip-text", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Quick tip about command palette"))
            }

            Text(String(localized: "localization-test.delete-action", defaultValue: "Delete", comment: "Delete action button"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.delete-confirmation", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Delete workspace confirmation message"))
        }
        .padding()
    }
}
