//
//  SettingsView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isShowSignUp: Bool
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        List {
            logOffButton
            
            deleteAccountButton

            if vm.authProviders.contains(.email) {
                mailSection
            }
            
            if vm.authUser?.isAnonymous == true {
                anonymousSection
            }
        }
        .onAppear {
            vm.getProviders()
            vm.setAuthUser()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(isShowSignUp: .constant(false))
        }
    }
}


extension SettingsView {
    private var mailSection: some View {
        Section {
            Button {
                Task {
                    do {
                        try await vm.updateEmail(email: "mail@mail.com")
                        print("Email Updated")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            } label: {
                Text("Update Email")
            }
            
            Button {
                Task {
                    do {
                        try await vm.updatePassword(password: "23")
                        print("Password Updated")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            } label: {
                Text("Update Password")
            }
            
            
            Button {
                Task {
                    do {
                        try await vm.resetPassword()
                        print("Password Reseted")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            } label: {
                Text("Reset Password")
            }
        } header: {
            Text("Service Buttons")
        }
    }
    
    private var anonymousSection: some View {
        Section {
            Button("Link Google Account") {
                Task {
                    do {
                        try await vm.linkGoogleAccount()
                        print("Google Auth Linked")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Link Apple Account") {
                Task {
                    do {
                        try await vm.linkAppleAccount()
                        print("Apple Auth Linked")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Link Email Account") {
                Task {
                    do {
                        try await vm.linkEmailAccount()
                        print("Email Auth Linked")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        } header: {
            Text("Create Account")
        }
    }
    
    private var logOffButton: some View {
        Button {
            do {
                try vm.logOff()
                isShowSignUp = true
            } catch {
                print(error.localizedDescription)
            }
        } label: {
            Text("Log out")
        }
    }
    
    #warning("make here an extra notification about: hey, it's permanent, you will newer have this info again. And if user confirm, make them login again for check")
    private var deleteAccountButton: some View {
        Button(role: .destructive) {
            Task {
                do {
                    try await vm.deleteAccount()
                    isShowSignUp = true
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            Text("Delete account")
        }
    }
}



