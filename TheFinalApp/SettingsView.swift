//
//  SettingsView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    
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

struct SettingsView: View {
    
    @Binding var isShowSignUp: Bool
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        List {
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
            
                serviceButtons
           

            
                
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
    private var serviceButtons: some View {
        
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
}



