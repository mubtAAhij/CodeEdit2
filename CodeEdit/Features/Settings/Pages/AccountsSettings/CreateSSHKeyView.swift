//
//  CreateSSHKeyView.swift
//  CodeEdit
//
//  Created by Austin Condiff on 4/28/23.
//

import SwiftUI

struct CreateSSHKeyView: View {
    @Environment(\.dismiss)
    private var dismiss

    enum KeyType: String, CaseIterable {
        case ed25519 = "ED25519"
        case ecdsa = "ECDSA"
        case rsa = "RSA"
        case dsa = "DSA"
    }

    @State var selectedKeyType: KeyType = .ed25519
    @State var passphrase: String = ""
    @State var confirmPassphrase: String = ""

    var body: some View {
        VStack {
            Form {
                Section(String(localized: "ssh-key.create-title", defaultValue: "Create SSH key", comment: "Section title for creating SSH key")) {
                    Picker(String(localized: "ssh-key.key-type-label", defaultValue: "Key Type", comment: "Label for SSH key type picker"), selection: $selectedKeyType) {
                        Text(String(localized: "ssh-key.type.ed25519", defaultValue: "ED25519", comment: "ED25519 key type"))
                            .tag(KeyType.ed25519)
                        Text(String(localized: "ssh-key.type.ecdsa", defaultValue: "ECDSA", comment: "ECDSA key type"))
                            .tag(KeyType.ecdsa)
                        Divider()
                        Group {
                            Text(String(localized: "ssh-key.type.rsa", defaultValue: "RSA", comment: "RSA key type")) + Text(String(localized: "ssh-key.less-secure-label", defaultValue: " (less secure)", comment: "Label indicating less secure key type")).foregroundColor(.secondary)
                        }
                        .tag(KeyType.rsa)
                        Group {
                            Text(String(localized: "ssh-key.type.dsa", defaultValue: "DSA", comment: "DSA key type")) + Text(String(localized: "ssh-key.less-secure-label", defaultValue: " (less secure)", comment: "Label indicating less secure key type")).foregroundColor(.secondary)
                        }
                        .tag(KeyType.dsa)
                    }
                    SecureField(String(localized: "ssh-key.passphrase-field", defaultValue: "Passphrase", comment: "Placeholder for passphrase field"), text: $passphrase)
                    if !passphrase.isEmpty {
                        SecureField(String(localized: "ssh-key.confirm-passphrase-field", defaultValue: "Confirm Passphrase", comment: "Placeholder for confirm passphrase field"), text: $confirmPassphrase)
                    }
                }
            }
            .formStyle(.grouped)
            .fixedSize()
            .scrollDisabled(true)
            HStack {
                Spacer()
                Button(String(localized: "ssh-key.cancel-button", defaultValue: "Cancel", comment: "Button to cancel SSH key creation")) {
                    dismiss()
                }
                Button(String(localized: "ssh-key.create-button", defaultValue: "Create", comment: "Button to create SSH key")) {
                    // create the ssh key
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
}
