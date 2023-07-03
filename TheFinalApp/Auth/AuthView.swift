//
//  AuthView.swift
//  TheFinalApp
//
//  Created by MM on 30.06.2023.
//

import SwiftUI

struct AuthView: View {
    
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
