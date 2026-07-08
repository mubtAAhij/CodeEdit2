import SwiftUI

/// Fixture page for localization pipeline testing.
/// This file intentionally contains user-facing literals.
struct LocalizationFeatureTestPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var projectCount = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Localization Feature Test Area")
                .font(.title2)

            Text("Use this page to verify multi-format localization extraction and apply flows.")

            Group {
                TextField("Username", text: $username)
                TextField("Email Address", text: $email)
                Button("Save Settings") {}
                Button("Reset to Defaults") {}
            }

            Divider()

            Text("Sync status: Connected")
            Text("Last backup completed successfully")
            Text("Found \(projectCount) recent projects")
            Text("New updates are available")
            Text("Failed to load extensions. Please try again.")

            HStack {
                Text("Quick tip:")
                Text("Press Command+Shift+P to open the command palette.")
            }

            Text("Delete")
                .foregroundStyle(.red)
            Text("Are you sure you want to permanently remove this workspace?")
        }
        .padding()
    }
}
