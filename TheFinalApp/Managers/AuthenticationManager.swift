//
//  AuthManager.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import Foundation
import FirebaseAuth

struct AuthResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    let isAnonymous: Bool
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}


enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case apple = "apple.com"
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {  }
    
    // Check User in local database
    func checkUserInDatabase() throws -> AuthResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthResultModel(user: user)
    }
    
    // Log off / Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        try await user.delete()
        
        
    }
    
    func getProvider() -> [AuthProviderOption] {
        guard let authProviders = Auth.auth().currentUser?.providerData else { return [AuthProviderOption]() }
        
        var providers = [AuthProviderOption]()
        for provider in authProviders {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else {
                assertionFailure("Please add option \(provider.providerID) to enum AuthProviderOption")
            }
        }
        return providers
    }
}

// MARK: SIGN IN EMAIL
extension AuthenticationManager {
    // Create User
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthResultModel {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthResultModel(user: authResult.user)
    }
    
    @discardableResult
    func SignInUser(email: String, password: String) async throws -> AuthResultModel {
    
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthResultModel(user: authResult.user)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }
        try await user.updateEmail(to: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse) }
        try await user.updatePassword(to: password)
    }
    
    func resetPassword(email: String) async throws {
        let passReserResult = try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}


// MARK: SIGN IN SSO

extension AuthenticationManager {
    
    @discardableResult
    func SignInGoogle(idToken: String, accessToken: String ) async throws -> AuthResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)
        return try await SignInCredential(credential: credential)
    }
    
    @discardableResult
    func SignInApple(token: SignInWithAppleResult) async throws -> AuthResultModel {
        // Initialize a Firebase credential, including the user's full name.
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: token.token, rawNonce: token.nonce)
        return try await SignInCredential(credential: credential)
    }
    
    func SignInCredential(credential: AuthCredential) async throws -> AuthResultModel {
        let item = try await Auth.auth().signIn(with: credential)
        return AuthResultModel(user: item.user)
    }
}


// MARK: SIGN IN ANONYMOUSLY

extension AuthenticationManager {
    @discardableResult
    func SignInAnonymous() async throws -> AuthResultModel {
        // Initialize a Firebase credential, including the user's full name.
        let authDataResult = try await Auth.auth().signInAnonymously()
        return try await AuthResultModel(user: authDataResult.user)
    }
    
    // link Anonymous Auth to a real Auth
    func linkEmail(email: String, password: String) async throws -> AuthResultModel {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        let authDataResult = try await user.link(with: credential)
        return AuthResultModel(user: authDataResult.user)
    }
    
    func linkApple(token: SignInWithAppleResult) async throws -> AuthResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: token.token, rawNonce: token.nonce)
        return try await linkCredential(credential: credential)
    }
    
    func linkGoogle(tokens: GoogleAuthModel) async throws -> AuthResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken,
                                                       accessToken:  tokens.accessToken)
        return try await linkCredential(credential: credential)
    }
    
    private func linkCredential(credential: AuthCredential) async throws -> AuthResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        let authDataResult = try await user.link(with: credential)
        return AuthResultModel(user: authDataResult.user)
    }
}
