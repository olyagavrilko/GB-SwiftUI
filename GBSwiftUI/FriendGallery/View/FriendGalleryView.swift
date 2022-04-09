//
//  FriendGalleryView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 24.03.2022.
//

import SwiftUI
import ASCollectionView

struct FriendGalleryView: View {
    
    @ObservedObject var viewModel: FriendGalleryViewModel

    var body: some View {
        ASCollectionView(data: viewModel.photos) { item, _ in
            GalleryRow(photoURL: URL(string: item.url ?? "")!)
        }
        .layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 3,
                lineSpacing: 2,
                itemSize: .absolute((UIScreen.main.bounds.width / 2) - 2)
            )
        }
        .padding(0)
        .navigationTitle(Text(viewModel.title))
        .onAppear {
            viewModel.getPhotosData()
        }
    }
}

//struct FriendGalleryView_Previews: PreviewProvider {
//
//    static let user = User(id: "some", name: "some", city: "some", photo: "some")
//
//    static var previews: some View {
//        FriendGalleryView(user: user)
//    }
//}
