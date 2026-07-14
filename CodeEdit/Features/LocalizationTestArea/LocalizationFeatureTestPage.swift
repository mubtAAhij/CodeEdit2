import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test-area.page.title", defaultValue: "Localization Feature Test Area", comment: "Title of the localization feature test area page"))
                .font(.title2)

            Text(String(localized: "localization-test-area.page.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of the localization test page purpose"))

            Group {
                TextField(String(localized: "localization-test-area.page.field.username", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test-area.page.field.email", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test-area.page.button.save", defaultValue: "Save Settings", comment: "Button to save settings")) {}
                Button(String(localized: "localization-test-area.page.button.reset", defaultValue: "Reset to Defaults", comment: "Button to reset to defaults")) {}
            }

            Divider()

            Text(String(localized: "localization-test-area.page.status.sync-connected", defaultValue: "Sync status: Connected", comment: "Status message showing sync is connected"))
            Text(String(localized: "localization-test-area.page.status.backup-success", defaultValue: "Last backup completed successfully", comment: "Status message showing backup completed successfully"))
            Text(String(format: String(localized: "localization-test-area.page.status.recent-projects", defaultValue: "Found %d recent projects", comment: "Status message showing number of recent projects found"), projectCount))
            Text(String(localized: "localization-test-area.page.status.updates-available", defaultValue: "New updates are available", comment: "Status message showing new updates are available"))
            Text(String(localized: "localization-test-area.page.error.extensions-failed", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message when extensions fail to load"))

            HStack {
                Text(String(localized: "localization-test-area.page.tip.label", defaultValue: "Quick tip:", comment: "Label for quick tip section"))
                Text(String(localized: "localization-test-area.page.tip.command-palette", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Tip about opening the command palette"))
            }

            Text(String(localized: "localization-test-area.page.action.delete", defaultValue: "Delete", comment: "Delete action label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test-area.page.confirm.delete-workspace", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for deleting workspace"))
        }
        .padding()
    }
}
