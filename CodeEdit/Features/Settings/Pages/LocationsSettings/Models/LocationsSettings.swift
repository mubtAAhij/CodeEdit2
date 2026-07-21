//
//  LocationsSettings.swift
//  CodeEdit
//
//  Created by Raymond Vleeshouwer on 24/06/23.
//

import Foundation

extension SettingsData {

    struct LocationsSettings: SearchableSettingsPage {

        /// The search keys
        var searchKeys: [String] {
            [
                String(localized: "settings.locations.search-key-settings", defaultValue: "Settings Location", comment: "Search key for settings location"),
                String(localized: "settings.locations.search-key-themes", defaultValue: "Themes Location", comment: "Search key for themes location"),
                String(localized: "settings.locations.search-key-extensions", defaultValue: "Extensions Location", comment: "Search key for extensions location")
            ]
        }
    }
}
