//
//  CircleImage.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 23.03.2022.
//

import SwiftUI
import Kingfisher

struct CircleImage: View {

    let imageURL: URL

    var body: some View {
        
        KFImage(imageURL)
            .cancelOnDisappear(true)
            .resizable()
            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .shadow(radius: 7)
    }
}
