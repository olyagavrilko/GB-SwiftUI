//
//  GalleryRow.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 29.03.2022.
//

import SwiftUI
import Kingfisher

struct GalleryRow: View {
    
    let photoURL: URL
    
    @State private var isLiked = false
    
    var body: some View {
        
        let width = (UIScreen.main.bounds.size.width - 3) / 2
        ZStack(alignment: .bottomTrailing) {
            KFImage(photoURL)
                .cancelOnDisappear(true)
                .resizable()
                .frame(width: width, height: width)
                .aspectRatio(contentMode: .fit)
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isLiked ? .red : .gray)
                .padding([.trailing, .bottom], 8)
                .rotationEffect(isLiked ? Angle.degrees(360) : Angle(degrees: 0))
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            
                            if !isLiked {
                                withAnimation(.interpolatingSpring(stiffness: 350, damping: 5)) {
                                    isLiked.toggle()
                                }
                            } else {
                                isLiked.toggle()
                            }
                        }
                )
        }
    }
}

//struct GalleryRow_Previews: PreviewProvider {
//
//    static let photo = Photo(id: "1", photo: UIImage(systemName: "ladybug"))
//
//    static var previews: some View {
//        GalleryRow(photo: photo)
//    }
//}
