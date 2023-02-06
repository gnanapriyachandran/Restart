//
//  OnboardingView.swift
//  Restart
//
//  Created by gnanapriya.chandran on 17/01/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage ("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating = false
    @State private var imageOffset: CGSize = .zero
    @State private var textTitle = "Share."
    let hapticFeedback = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack {
            Color("ColorPink")
                .ignoresSafeArea(.all,edges: .all)
            VStack {
//                Text("Onboarding")
//                    .font(.headline)
//                    .padding(10)
//
//                Button("Start") {
//                    isOnboardingViewActive = false
//                }
//                .foregroundColor(.black)
                Spacer()
                
                //MARK: - HEADER
                VStack {
                    Text(textTitle)
                        .foregroundColor(.purple)
                        .font(.system(size: 100))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                    Text("Giving is love!!!")
                        .foregroundColor(.brown)
                        .font(.system(size: 40, design: .serif))
                        .padding(.horizontal,10)
                }//: VStack
                
                Spacer()
                
                
                
                //MARK: - BODY
                
                ZStack{
                    HaloView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(gesture.translation.width) <= 150 {
                                    imageOffset = gesture.translation
                                    textTitle = "Give."
                                }
                            })
                                .onEnded({ gesture in
                                    imageOffset = .zero
                                    textTitle = "Share."
                                })
                            
                        )
                        .animation(.easeOut(duration: 0.8), value: imageOffset)
                       
                } //: Zstack
                Spacer()
                    .overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.purple)
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(imageOffset != .zero ? 0 : 1)
                }
                
                //MARK: - FOOTER
                
                ZStack {
                    
                    //MARK: - 1.BACKGROUND
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    //MARK: - 2.CALL-TO-ACTION
                    
                    Text("Get Started !!")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(alignment: .center)

                    
                    //3. CAPSULE DYNAMIC WIDTH
                    
                    HStack {
                        Capsule()
                            .fill(.cyan)
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                
                    //MARK: - 4. DRAGGABLE CIRCLE
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(.cyan)
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    } else {
                                        hapticFeedback.notificationOccurred(.success)
                                        isOnboardingViewActive = false
                                        playSound(sound: "chimeup", type: ".mp3")
                                    }
                                })
                                .onEnded({ _ in
                                    buttonOffset = 0
                                    hapticFeedback.notificationOccurred(.warning)
                                   
                                })
                        )
                        //: DragGesture
                        
//                        .onTapGesture {
//                            isOnboardingViewActive = false
//                        }
                        
                        Spacer()
                            
                    }//: HSTACK
                    
                }//: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(5)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeIn, value: isAnimating)
                

            } //: Vstack
        }//: Zstack
        
        .onAppear() {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
