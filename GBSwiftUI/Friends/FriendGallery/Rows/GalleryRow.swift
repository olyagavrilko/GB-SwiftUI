//
//  GalleryRow.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 29.03.2022.
//

import SwiftUI

struct GalleryRow: View {
    
    let photo: Photo
    
    var body: some View {
        VStack {
            Image(uiImage: photo.photo ?? UIImage())
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct GalleryRow_Previews: PreviewProvider {
    
    static let photo = Photo(id: "1", photo: UIImage(systemName: "ladybug"))
    
    static var previews: some View {
        GalleryRow(photo: photo)
    }
}
