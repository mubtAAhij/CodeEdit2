import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test-area.page.title", defaultValue: "Localization Feature Test Area", comment: "Title for localization test area page"))
                .font(.title2)

            Text(String(localized: "localization-test-area.page.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description of localization test page purpose"))

            Group {
                TextField(String(localized: "localization-test-area.field.username", defaultValue: "Username", comment: "Username text field placeholder"), text: $username)
                TextField(String(localized: "localization-test-area.field.email", defaultValue: "Email Address", comment: "Email address text field placeholder"), text: $email)
                Button(String(localized: "localization-test-area.button.save-settings", defaultValue: "Save Settings", comment: "Button to save settings")) {}
                Button(String(localized: "localization-test-area.button.reset-defaults", defaultValue: "Reset to Defaults", comment: "Button to reset settings to defaults")) {}
            }

            Divider()

            Text(String(localized: "localization-test-area.status.sync-connected", defaultValue: "Sync status: Connected", comment: "Sync status when connected"))
            Text(String(localized: "localization-test-area.status.backup-complete", defaultValue: "Last backup completed successfully", comment: "Last backup completion status"))
            Text(String(format: String(localized: "localization-test-area.status.projects-found", defaultValue: "Found %d recent projects", comment: "Number of recent projects found"), projectCount))
                .accessibilityLabel(String(format: String(localized: "localization-test-area.status.projects-found", defaultValue: "Found %d recent projects", comment: "Number of recent projects found"), projectCount))
            Text(String(localized: "localization-test-area.status.updates-available", defaultValue: "New updates are available", comment: "New updates availability message"))
            Text(String(localized: "localization-test-area.error.extensions-load-failed", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message when extensions fail to load"))

            HStack {
                Text(String(localized: "localization-test-area.tip.label", defaultValue: "Quick tip:", comment: "Label for quick tip section"))
                Text(String(localized: "localization-test-area.tip.command-palette", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Tip about opening command palette"))
            }

            Text(String(localized: "localization-test-area.action.delete", defaultValue: "Delete", comment: "Delete action label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test-area.confirm.delete-workspace", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for workspace deletion"))
        }
        .padding()
    }
}
