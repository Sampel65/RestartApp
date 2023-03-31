//
//  HomeView.swift
//  RESTART
//
//  Created by Sampel on 27/02/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage ("onboarding") var isOnboardingViewActive : Bool = false
    @State private var IsAanimating : Bool = false
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                        .stroke(.gray.opacity(0.2), lineWidth: 40)
                    .frame(width: 260, height: 260, alignment: .center)
           
                    Circle()
                        .stroke(.gray.opacity(0.2), lineWidth: 80)
                        .frame(width: 260, height: 260, alignment: .center)
            }
            .blur(radius: IsAanimating ? 0: 10)
            .opacity(IsAanimating ? 1 : 0)
            .scaleEffect(IsAanimating ? 1 : 0.5)
            .animation(.easeOut(duration: 1), value: IsAanimating)
            .onAppear(perform: {
                IsAanimating = true
            })
                                
            VStack(spacing : 20) {
                
                Spacer()
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y : IsAanimating ? 35 : -35)
                    .animation(Animation.easeInOut(duration: 4).repeatForever(), value: IsAanimating)
                Spacer()
                
                Text("The tome that leads to mastery is dependent on the intensity of our focus.")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(10)
                Spacer()
                
                Button(action: {
                    withAnimation{
                        isOnboardingViewActive = true

                            }
                    
                }) {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                
                    Text ("Restart")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large )
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                IsAanimating = true
            })
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
