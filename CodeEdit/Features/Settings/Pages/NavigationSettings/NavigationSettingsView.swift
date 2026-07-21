//
//  NavigationSettingsView.swift
//  CodeEdit
//
//  Created by Austin Condiff on 3/4/24.
//

import SwiftUI

struct NavigationSettingsView: View {
    @AppSettings(\.navigation)
    var settings

    var body: some View {
        SettingsForm {
            Section {
                navigationStyle
            }
        }
    }
}

private extension NavigationSettingsView {
    private var navigationStyle: some View {
        Picker(String(localized: "settings.navigation.style-label", defaultValue: "Navigation Style", comment: "Label for navigation style picker"), selection: $settings.navigationStyle) {
            Text(String(localized: "settings.navigation.open-in-tabs", defaultValue: "Open in Tabs", comment: "Navigation style option to open files in tabs"))
                .tag(SettingsData.NavigationStyle.openInTabs)
            Text(String(localized: "settings.navigation.open-in-place", defaultValue: "Open in Place", comment: "Navigation style option to open files in place"))
                .tag(SettingsData.NavigationStyle.openInPlace)
        }
    }
}
