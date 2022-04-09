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
    
    var body: some View {
        
        let width = (UIScreen.main.bounds.size.width - 3) / 2
        
        KFImage(photoURL)
            .cancelOnDisappear(true)
            .resizable()
            .frame(width: width, height: width)
            .aspectRatio(contentMode: .fill)
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
