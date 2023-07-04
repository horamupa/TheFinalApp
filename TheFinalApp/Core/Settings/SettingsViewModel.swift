//
//  SettingsViewModel.swift
//  TheFinalApp
//
//  Created by MM on 04.07.2023.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func getProviders() {
        authProviders = AuthManager.shared.getProvider()
    }
    
    func logOff() throws {
        try AuthManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let user = try AuthManager.shared.checkUserInDatabase()
        guard let mail = user.email else { throw URLError(.cancelled) }
        try await AuthManager.shared.resetPassword(email: mail)
    }
    
    func updateEmail(email: String) async throws {
        let fakeEmail = "twst@test.com"
        try await AuthManager.shared.updateEmail(email: fakeEmail)
    }
    
    func updatePassword(password: String) async throws {
        let fakePass = "123454"
        try await AuthManager.shared.updatePassword(password: fakePass)
    }
}
