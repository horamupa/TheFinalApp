//
//  AuthView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI
import GoogleSignInSwift

@MainActor
final class AuthViewModel: ObservableObject {
    
    func signInWithGoogle() async throws {
        // Get user from GID
        let user = try await SignInGoogleHelper().signIn()
            
        // Login to FireBase with Google User
        let result = try await AuthManager.shared.SignInGoogle(idToken: user.idToken, accessToken: user.accessToken)
    }
}

struct AuthView: View {
    
    @StateObject var vm = AuthViewModel()
    @Binding var isShowSignUp: Bool
    
    var body: some View {
        VStack {
            NavigationLink {
                MailAuthView(isShowSignUp: $isShowSignUp)
            } label: {
                Text("Sign in with email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.blue
                    }
                    .cornerRadius(10)
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await vm.signInWithGoogle()
                        isShowSignUp = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            Spacer()

        }
        .padding()
        .navigationTitle("Sign in")
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthView(isShowSignUp: .constant(false))
        }
    }
}
