//
//  RootView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI
import Firebase

struct RootView: View {
    
    @State var isShowSignUp: Bool = false
    var body: some View {
        ZStack {
            if isShowSignUp != false {
                NavigationStack {
                    SettingsView(isShowSignUp: $isShowSignUp)
                }
            }
        }
        .onAppear {
            guard let user = try? AuthManager.shared.checkUserInDatabase() else {
                return
            }
            self.isShowSignUp = user == nil ? true : false
        }
        .fullScreenCover(isPresented: $isShowSignUp) {
            NavigationStack {
                AuthView(isShowSignUp: $isShowSignUp)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
