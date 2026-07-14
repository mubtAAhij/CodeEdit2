import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "localization-test.page.title", defaultValue: "Localization Feature Test Area", comment: "Title of the localization test area page"))
                .font(.title2)

            Text(String(localized: "localization-test.page.description", defaultValue: "Use this page to verify multi-format localization extraction and apply flows.", comment: "Description explaining the purpose of the localization test page"))

            Group {
                TextField(String(localized: "localization-test.field.username", defaultValue: "Username", comment: "Username text field label"), text: $username)
                TextField(String(localized: "localization-test.field.email", defaultValue: "Email Address", comment: "Email address text field label"), text: $email)
                Button(String(localized: "localization-test.button.save", defaultValue: "Save Settings", comment: "Button to save settings")) {}
                Button(String(localized: "localization-test.button.reset", defaultValue: "Reset to Defaults", comment: "Button to reset settings to defaults")) {}
            }

            Divider()

            Text(String(localized: "localization-test.status.sync", defaultValue: "Sync status: Connected", comment: "Sync status message indicating connected state"))
            Text(String(localized: "localization-test.status.backup", defaultValue: "Last backup completed successfully", comment: "Backup completion success message"))
            Text(String(format: String(localized: "localization-test.status.projects", defaultValue: "Found %d recent projects", comment: "Status message showing number of recent projects found"), projectCount))
            Text(String(localized: "localization-test.status.updates", defaultValue: "New updates are available", comment: "Message indicating new updates are available"))
            Text(String(localized: "localization-test.error.extensions", defaultValue: "Failed to load extensions. Please try again.", comment: "Error message when extensions fail to load"))

            HStack {
                Text(String(localized: "localization-test.tip.label", defaultValue: "Quick tip:", comment: "Label for quick tip section"))
                Text(String(localized: "localization-test.tip.command-palette", defaultValue: "Press Command+Shift+P to open the command palette.", comment: "Quick tip about opening the command palette"))
            }

            Text(String(localized: "localization-test.action.delete", defaultValue: "Delete", comment: "Delete action button label"))
                .foregroundStyle(.red)
            Text(String(localized: "localization-test.confirmation.delete-workspace", defaultValue: "Are you sure you want to permanently remove this workspace?", comment: "Confirmation message for permanently deleting a workspace"))
        }
        .padding()
    }
}
