//
//  WorkoutView.swift
//  TheFinalApp
//
//  Created by MM on 12.07.2023.
//

import SwiftUI

struct WorkoutView: View {
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottom) {
                Image("coupleRunning")
                    .resizable()
                    .scaledToFill()
                LinearGradient(gradient: Gradient(colors: [.clear, Color(.systemBackground)]), startPoint: .top, endPoint: .bottom)
                VStack(alignment: .leading) {
                    Text("Decompress\nYour Full Back")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("for Instant Pain Relief")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .overlay(alignment: .topTrailing) {
                HStack {
                    Button {
                        // code
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    
                    Button {
                        // code
                    } label: {
                        Image(systemName: "bookmark")
                    }
                }
                .foregroundColor(Color(.label))
                .padding(.trailing, 32)
                .padding(.top, 32)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Label("6 min, Beginners", systemImage: "timer")
                Label("Total-Body Strength", systemImage: "figure.run")
                Label("None equip", systemImage: "dumbbell")
                Label("Latin Pop, Dance", systemImage: "music.quarternote.3")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .padding(.horizontal)
                .padding(.bottom, 100)
        }
        .overlay(alignment: .bottom) {
            HStack {
                Button {
                    // Some code
                } label: {
                    ZStack {
                        Capsule()
                            .padding(.trailing)
                            
                        Text("Start workout")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.label))
                    }
                }

                Button {
                    // Some code
                } label: {
                    ZStack {
                        Circle()
                        Image(systemName: "music.note")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.label))
                    }
                }

                
            }
            .foregroundColor(Color(.systemGray4))
            .frame(height: 55)
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
