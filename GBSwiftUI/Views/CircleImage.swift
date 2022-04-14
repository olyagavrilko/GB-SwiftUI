//
//  CircleImage.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 23.03.2022.
//

import SwiftUI
import Kingfisher

struct CircleImage: View {
    
    @State private var isScaled = false
    @State private var isSpring = false

    let imageURL: URL

    var body: some View {
        
        KFImage(imageURL)
            .cancelOnDisappear(true)
            .resizable()
            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .shadow(radius: 7)
            .scaleEffect(isScaled ? 0.25 : 1)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isScaled.toggle()
                    withAnimation(.interpolatingSpring(mass: 0.5, stiffness: 250, damping: 5, initialVelocity: 1)) {
                        isScaled.toggle()
                        isSpring.toggle()
                    }
                }
            }
    }
}
