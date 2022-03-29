//
//  FriendGalleryView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 24.03.2022.
//

import SwiftUI
import ASCollectionView

struct Photo: Identifiable {
    let id: String
    let photo: UIImage?
}

struct FriendGalleryView: View {

    let user: User
    
    @State private var photos: [Photo] = [
        Photo(id: "1", photo: UIImage(systemName: "hare")),
        Photo(id: "2", photo: UIImage(systemName: "tortoise")),
        Photo(id: "3", photo: UIImage(systemName: "ladybug"))
    ]

    var body: some View {
        ASCollectionView(data: photos) { item, _ in
            GalleryRow(photo: item)
        }
        .layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 0,
                lineSpacing: 16
            )
        }
        .navigationTitle(Text(user.name))
    }
}

struct FriendGalleryView_Previews: PreviewProvider {

    static let user = User(id: "some", name: "some", city: "some", photo: "some")

    static var previews: some View {
        FriendGalleryView(user: user)
    }
}
