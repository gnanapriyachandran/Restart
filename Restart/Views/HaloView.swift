//
//  HaloView.swift
//  Restart
//
//  Created by gnanapriya.chandran on 30/01/23.
//

import SwiftUI

struct HaloView: View {
    
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            Ellipse()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 400, alignment: .center)
            Ellipse()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 400, alignment: .center)
        }//: ZStack
        .blur(radius: isAnimating ? 0:10)
        .opacity(isAnimating ? 1:0)
        .scaleEffect(isAnimating ? 1:0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
        
    }
}

struct HaloView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorPink")
                .ignoresSafeArea()
            HaloView(shapeColor: .white, shapeOpacity: 0.2)
        }
       
    }
}
