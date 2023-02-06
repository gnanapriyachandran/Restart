//
//  HomeView.swift
//  Restart
//
//  Created by gnanapriya.chandran on 17/01/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage ("onboarding") var isOnboardingViewActive =  false
    @State private var isAnimating = false
    
    var body: some View {

        ZStack {
           
            VStack(spacing: 20) {
                    //MARK: - HEADER
                    Spacer()
                ZStack {
                    HaloView(shapeColor: .gray, shapeOpacity: 0.1)
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .offset(y: isAnimating ? 35 : -35)
                        .animation(Animation.easeInOut(duration: 4)
                            .repeatForever()
                                   , value: isAnimating
                        )
                }
                    Spacer()
                    
                    //MARK: - BODY
                    Text("Focus is the key to Success !!!")
                        .font(.headline)
                        .foregroundColor(.cyan)
                        .padding()
                    
                    //MARK: - FOOTER
                    Spacer()
                    Button {
                        playSound(sound: "success", type: ".m4a")
                        isOnboardingViewActive = true
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        Text("Restart")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    
                    

                    
            } //: Vstack
        }.onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                isAnimating = true
            })
            
        }
       
      
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
