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
            
            if vm.authProviders.contains(.email) {
                mailSection
            }
        }
        .onAppear {
            vm.getProviders()
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
}



