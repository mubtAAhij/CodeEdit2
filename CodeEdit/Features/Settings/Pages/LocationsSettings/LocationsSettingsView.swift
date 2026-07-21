//
//  LocationSettingsView.swift
//  CodeEdit
//
//  Created by Raymond Vleeshouwer on 02/04/23.
//

import SwiftUI

/// A view that implements the `Locations` settings section
struct LocationsSettingsView: View {
    var body: some View {
        SettingsForm {
            Section {
                applicationSupportLocation
                settingsLocation
                themesLocation
                extensionsLocation
            }
        }
    }
}

private extension LocationsSettingsView {
    @ViewBuilder private var applicationSupportLocation: some View {
        ExternalLink(destination: Settings.shared.baseURL) {
            Text(String(localized: "settings.locations.application-support", defaultValue: "Application Support", comment: "Label for application support folder location"))
            Text(Settings.shared.baseURL.path)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    private var settingsLocation: some View {
        ExternalLink(destination: ThemeModel.shared.settingsURL) {
            Text(String(localized: "settings.locations.settings-file", defaultValue: "Settings", comment: "Label for settings file location"))
            Text(ThemeModel.shared.settingsURL.path)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    private var themesLocation: some View {
        ExternalLink(destination: ThemeModel.shared.themesURL) {
            Text(String(localized: "settings.locations.themes-folder", defaultValue: "Themes", comment: "Label for themes folder location"))
            Text(ThemeModel.shared.themesURL.path)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    private var extensionsLocation: some View {
        ExternalLink(destination: ThemeModel.shared.extensionsURL) {
            Text(String(localized: "settings.locations.extensions-folder", defaultValue: "Extensions", comment: "Label for extensions folder location"))
            Text(ThemeModel.shared.extensionsURL.path())
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}
