//
//  SignInGoogleHelper.swift
//  TheFinalApp
//
//  Created by MM on 04.07.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleAuthModel {
    let idToken: String
    let accessToken: String
//    let name: String?
//    let email: String?
}


final class SignInGoogleHelper {
    #warning("we can grab  userName from google from here")
    @MainActor
    func signIn() async throws -> GoogleAuthModel {
        // Getting Root VC for GID
        guard let topVC = UIApplication.shared.windows.first?.rootViewController else { throw URLError(.cannotCreateFile) }
        // Ask Google SDK For User
        let googleResults = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = googleResults.user.idToken?.tokenString else {
            print("Token Error")
            throw URLError(.cannotCreateFile)
          }
        let accessToken = googleResults.user.accessToken.tokenString
//        let name = googleResults.user.profile?.name
//        let email = googleResults.user.profile?.email
        return GoogleAuthModel(idToken: idToken, accessToken: accessToken)
    }
}
