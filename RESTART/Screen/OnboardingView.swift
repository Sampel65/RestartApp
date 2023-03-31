//
//  OnboardingView.swift
//  RESTART
//
//  Created by Sampel on 27/02/2023.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage ("onboarding") var isOnboardingViewActive : Bool = true
    
    @State private var buttonWidth : Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset : CGFloat = 0
    @State private var IsAanimating : Bool = false
    @State private var ImageOffset : CGSize = .zero
    
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all)
            
            VStack(spacing : 20){
                //MARK : HEADER
                Spacer()
                
                VStack (spacing : 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    it's not how much we give but how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                }
                .opacity(IsAanimating ? 1 : 0)
                .offset(y : IsAanimating ? 0 : -40)
                .animation(.easeOut (duration: 1), value: IsAanimating)
                // MARK : CENTER
                ZStack{
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 260, height: 260, alignment: .center)
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                    }
                    .blur(radius: IsAanimating ? 0: 10)
                    .opacity(IsAanimating ? 1 : 0)
                    .scaleEffect(IsAanimating ? 1 : 0.5)
                    .animation(.easeOut(duration: 1), value: IsAanimating)
                    .onAppear(perform: {
                        IsAanimating = true
                    })
                    .offset(x: ImageOffset.width * -1)
                    .blur(radius: abs(ImageOffset.width / 5))
                    .animation(.easeOut, value: ImageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(IsAanimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: IsAanimating)
                        .offset(x: ImageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(ImageOffset.width/20)))
                        .gesture(DragGesture()
                            .onChanged { gesture in
                                if abs(ImageOffset.width) <= 150 {
                                    ImageOffset = gesture.translation
                                }
                        }
                            .onEnded { _ in
                                ImageOffset = .zero
                            }
                    )
                        .animation(.easeOut(duration: 1), value: ImageOffset)
                    
                }
                Spacer()
                
                ZStack{
                    
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    
                    Text("Get started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                        
                    }
                    HStack {
                        ZStack{
                                    Circle()
                                        .fill(Color("ColorRed"))
                                    
                                    Circle()
                                        .fill(Color.black.opacity(0.15))
                                        .padding(8)
                                    Image(systemName: "chevron.right.2")
                                        .font(.system(size: 24,weight: .bold))
                                    
                                    
                                }
                                .foregroundColor(.white)
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x : buttonOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged {
                                        gesture in
                                        if gesture.translation.width > 0  && buttonOffset <= buttonWidth - 80 {
                                            buttonOffset = gesture.translation.width
                                        }
                                    }
                                    .onEnded { _ in
                                        
                                        withAnimation(Animation.easeOut(duration: 0.7)) {
                                            if buttonOffset > buttonWidth / 2 {
                                                buttonOffset = buttonWidth - 80
                                                isOnboardingViewActive = false
                                            } else {
                                                buttonOffset = 0
                                            }
                                        }
                                        
                                    }
                            )
                        Spacer()
                    }
                        
                }
                .frame(width : buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(IsAanimating ? 1 : 0)
                .offset(y : IsAanimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: IsAanimating)
            }
        }
        .onAppear(perform: {
             IsAanimating = true
        })
            
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
