//
//  InvisiblesSettingsView.swift
//  CodeEdit
//
//  Created by Khan Winter on 6/13/25.
//

import SwiftUI

struct InvisiblesSettingsView: View {
    typealias Config = SettingsData.TextEditingSettings.InvisibleCharactersConfig

    @Binding var invisibleCharacters: Config

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    VStack {
                        Toggle(isOn: $invisibleCharacters.showSpaces) { Text(String(localized: "invisibles-settings.show-spaces", defaultValue: "Show Spaces", comment: "Toggle to show space characters")) }
                        if invisibleCharacters.showSpaces {
                            TextField(
                                text: $invisibleCharacters.spaceReplacement,
                                prompt: Text(String(format: String(localized: "invisibles-settings.default-space", defaultValue: "Default: %@", comment: "Default space character prompt"), Config.default.spaceReplacement))
                            ) {
                                Text(String(localized: "invisibles-settings.space-character", defaultValue: "Character used to render spaces", comment: "Label for space replacement character field"))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .autocorrectionDisabled()
                        }
                    }

                    VStack {
                        Toggle(isOn: $invisibleCharacters.showTabs) { Text(String(localized: "invisibles-settings.show-tabs", defaultValue: "Show Tabs", comment: "Toggle to show tab characters")) }
                        if invisibleCharacters.showTabs {
                            TextField(
                                text: $invisibleCharacters.tabReplacement,
                                prompt: Text(String(format: String(localized: "invisibles-settings.default-tab", defaultValue: "Default: %@", comment: "Default tab character prompt"), Config.default.tabReplacement))
                            ) {
                                Text(String(localized: "invisibles-settings.tab-character", defaultValue: "Character used to render tabs", comment: "Label for tab replacement character field"))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .autocorrectionDisabled()
                        }
                    }

                    VStack {
                        Toggle(isOn: $invisibleCharacters.showLineEndings) { Text(String(localized: "invisibles-settings.show-line-endings", defaultValue: "Show Line Endings", comment: "Toggle to show line ending characters")) }
                        if invisibleCharacters.showLineEndings {
                            TextField(
                                text: $invisibleCharacters.lineFeedReplacement,
                                prompt: Text(String(format: String(localized: "invisibles-settings.default-linefeed", defaultValue: "Default: %@", comment: "Default line feed character prompt"), Config.default.lineFeedReplacement))
                            ) {
                                Text(String(localized: "invisibles-settings.linefeed-character", defaultValue: "Character used to render line feeds (\\n)", comment: "Label for line feed replacement character field"))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .autocorrectionDisabled()

                            TextField(
                                text: $invisibleCharacters.carriageReturnReplacement,
                                prompt: Text(String(format: String(localized: "invisibles-settings.default-carriage-return", defaultValue: "Default: %@", comment: "Default carriage return character prompt"), Config.default.carriageReturnReplacement))
                            ) {
                                Text(String(localized: "invisibles-settings.carriage-return-character", defaultValue: "Character used to render carriage returns (Microsoft-style line endings)", comment: "Label for carriage return replacement character field"))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .autocorrectionDisabled()

                            TextField(
                                text: $invisibleCharacters.paragraphSeparatorReplacement,
                                prompt: Text(String(format: String(localized: "invisibles-settings.default-paragraph-separator", defaultValue: "Default: %@", comment: "Default paragraph separator character prompt"), Config.default.paragraphSeparatorReplacement))
                            ) {
                                Text(String(localized: "invisibles-settings.paragraph-separator-character", defaultValue: "Character used to render paragraph separators", comment: "Label for paragraph separator replacement character field"))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .autocorrectionDisabled()

                            TextField(
                                text: $invisibleCharacters.lineSeparatorReplacement,
                                prompt: Text(String(format: String(localized: "invisibles-settings.default-line-separator", defaultValue: "Default: %@", comment: "Default line separator character prompt"), Config.default.lineSeparatorReplacement))
                            ) {
                                Text(String(localized: "invisibles-settings.line-separator-character", defaultValue: "Character used to render line separators", comment: "Label for line separator replacement character field"))
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .autocorrectionDisabled()
                        }
                    }
                } header: {
                    Text(String(localized: "invisibles-settings.header", defaultValue: "Invisible Characters", comment: "Section header for invisible characters settings"))
                    Text(String(localized: "invisibles-settings.description", defaultValue: "Toggle whitespace symbols CodeEdit will render with replacement characters.", comment: "Description of invisible characters settings"))
                }
                .textFieldStyle(.roundedBorder)
            }
            .formStyle(.grouped)
            Divider()
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text(String(localized: "invisibles-settings.done", defaultValue: "Done", comment: "Button to close invisible characters settings"))
                        .frame(minWidth: 56)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
