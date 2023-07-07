//
//  AuthView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI
import GoogleSignInSwift

@MainActor

final class AuthenticationViewModel: ObservableObject {
   
    @Published var didSignInWithApple: Bool = false
//    let signInAppleHelper = SignInAppleHelper()
    
    func signInWithGoogle() async throws {
        let user = try await SignInGoogleHelper().signIn()  // Get user from GID
        
        let result = try await AuthManager.shared.SignInGoogle(idToken: user.idToken, accessToken: user.accessToken) // Login to FireBase with Google User
    }
    
    func signInWithApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        
        try await AuthManager.shared.SignInApple(token: tokens)
        
//        signInAppleHelper.startSignInWithAppleFlow { result in
//            switch result {
//            case .success(let result):
//                Task {
//                    do {
//                        try await AuthManager.shared.SignInApple(token: result)
//                        self.didSignInWithApple = true
//                    } catch {
//
//                    }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

struct AuthView: View {
    
    @StateObject var vm = AuthenticationViewModel()
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
            
            Button(action: {
                Task {
                    do {
                        try await vm.signInWithApple()
                        isShowSignUp = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            })
            .frame(height: 55)
            
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

