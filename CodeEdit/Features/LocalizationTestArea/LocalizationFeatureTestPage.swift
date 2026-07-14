import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test-page.title", defaultValue: "Localization Feature Test Area", comment: "Title of localization test page"))
                .font(.title2)

            Text(String(localized: "localization-test-page.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of test page purpose"))

            Group {
                TextField(String(localized: "localization-test-page.field.username", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test-page.field.email", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test-page.button.save", defaultValue: "Save Settings", comment: "Save settings button")) {}
                Button(String(localized: "localization-test-page.button.reset", defaultValue: "Reset to Defaults", comment: "Reset to defaults button")) {}
            }

            Divider()

            Text(String(localized: "localization-test-page.status.sync", defaultValue: "Sync status: Connected", comment: "Sync connection status message"))
            Text(String(localized: "localization-test-page.status.backup", defaultValue: "Last backup completed successfully", comment: "Backup completion status message"))
            Text(String(format: String(localized: "localization-test-page.status.projects", defaultValue: "Found %d recent projects", comment: "Recent projects count message"), projectCount))
            Text(String(localized: "localization-test-page.status.updates", defaultValue: "New updates are available", comment: "Updates available message"))
            Text(String(localized: "localization-test-page.error.extensions", defaultValue: "Failed to load extensions. Please try again.", comment: "Extension loading failure message"))

            HStack {
                Text(String(localized: "localization-test-page.tip.label", defaultValue: "Quick tip:", comment: "Quick tip label"))
                Text(String(localized: "localization-test-page.tip.command-palette", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Command palette keyboard shortcut tip"))
            }

            Text(String(localized: "localization-test-page.button.delete", defaultValue: "Delete", comment: "Delete button label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test-page.alert.delete-workspace", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Delete workspace confirmation message"))
        }
        .padding()
    }
}
