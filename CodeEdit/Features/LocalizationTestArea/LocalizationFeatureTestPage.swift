import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test.title", defaultValue: "Localization Feature Test Area", comment: "Title of localization test page"))
                .font(.title2)

            Text(String(localized: "localization-test.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of localization test page purpose"))

            Group {
                TextField(String(localized: "localization-test.field.username", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test.field.email", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test.button.save", defaultValue: "Save Settings", comment: "Save settings button")) {}
                Button(String(localized: "localization-test.button.reset", defaultValue: "Reset to Defaults", comment: "Reset to defaults button")) {}
            }

            Divider()

            Text(String(localized: "localization-test.status.sync", defaultValue: "Sync status: Connected", comment: "Sync status message"))
            Text(String(localized: "localization-test.status.backup", defaultValue: "Last backup completed successfully", comment: "Backup completion message"))
            Text(String(format: String(localized: "localization-test.status.projects", defaultValue: "Found %d recent projects", comment: "Recent projects count message"), projectCount))
            Text(String(localized: "localization-test.status.updates", defaultValue: "New updates are available", comment: "Updates available message"))
            Text(String(localized: "localization-test.error.extensions", defaultValue: "Failed to load extensions. Please try again.", comment: "Extension loading error message"))

            HStack {
                Text(String(localized: "localization-test.tip.label", defaultValue: "Quick tip:", comment: "Quick tip label"))
                Text(String(localized: "localization-test.tip.command-palette", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Command palette keyboard shortcut tip"))
            }

            Text(String(localized: "localization-test.action.delete", defaultValue: "Delete", comment: "Delete action label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.confirm.delete-workspace", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Workspace deletion confirmation message"))
        }
        .padding()
    }
}
