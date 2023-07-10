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
    @Published var authUser: AuthResultModel? = nil
    
    func getProviders() {
        authProviders = AuthenticationManager.shared.getProvider()
    }
    
    func setAuthUser() {
        authUser = try? AuthenticationManager.shared.checkUserInDatabase()
    }
    
    func logOff() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.deleteUser()
    }
    
    func resetPassword() async throws {
        let user = try AuthenticationManager.shared.checkUserInDatabase()
        guard let mail = user.email else { throw URLError(.cancelled) }
        try await AuthenticationManager.shared.resetPassword(email: mail)
    }
    
    func updateEmail(email: String) async throws {
        let fakeEmail = "twst@test.com"
        try await AuthenticationManager.shared.updateEmail(email: fakeEmail)
    }
    
    func updatePassword(password: String) async throws {
        let fakePass = "123454"
        try await AuthenticationManager.shared.updatePassword(password: fakePass)
    }
    
    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
    }
    
    func linkAppleAccount() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        self.authUser = try await AuthenticationManager.shared.linkApple(token: tokens)
    }
    
    func linkEmailAccount() async throws {
        let email = "twst@test.com"
        let password = "123454"
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }
    
}
