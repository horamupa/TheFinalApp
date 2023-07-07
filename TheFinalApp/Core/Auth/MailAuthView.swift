//
//  MailAuthView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI

@MainActor
final class MailAuthViewModel: ObservableObject {
    @Published var mail: String = ""
    @Published var password: String = ""
    
    let am = AuthManager.shared
    
    func SignUp() async throws {
        guard !mail.isEmpty, !password.isEmpty else {
            print("mail or password is empty")
            return
        }
        let result = try await am.createUser(email: mail, password: password)
    }
    
    func SignIn() async throws {
        guard !mail.isEmpty, !password.isEmpty else {
            print("mail or password is empty")
            return
        }
        let result = try await am.SignInUser(email: mail, password: password)
    }
}

struct MailAuthView: View {
    
    @StateObject var vm: MailAuthViewModel = MailAuthViewModel()
    @Binding var isShowSignUp: Bool
    var body: some View {
        VStack {
            TextField("enter your email", text: $vm.mail)
                .padding()
                .background(content: {Color.gray.opacity(0.3)})
                .cornerRadius(10)
            SecureField("enter your password", text: $vm.password)
                .padding()
                .background(content: {Color.gray.opacity(0.3)})
                .cornerRadius(10)
            Button {
                Task {
                    // Trying SignUp and if fails when trying to SignIn
                    do {
                        try await vm.SignUp()
                        isShowSignUp = false
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                    do {
                        try await vm.SignIn()
                        isShowSignUp = false
                        return
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.blue
                    }
                    .cornerRadius(10)
            }
            Spacer()

        }
        .padding()
        .navigationTitle("Sign in with mail")
    }
}

struct MailAuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MailAuthView(isShowSignUp: .constant(false))
        }
    }
}
