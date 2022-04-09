//
//  FriendsView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 24.03.2022.
//

import SwiftUI
import RealmSwift

struct FriendsView: View {
    
    @ObservedObject var viewModel: FriendsViewModel
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.friends) { friend in
            NavigationLink(
                destination: LazyView(FriendGalleryView(viewModel: FriendGalleryViewModel(photoService: PhotoService(), user: friend))),
                label: {
                    UserRow(userName: friend.firstName, city: friend.city?.title ?? "", imageURL: friend.photo100)
                })
        }
        .listStyle(.plain)
        .navigationTitle(Text("Друзья"))
        .onAppear {
            viewModel.getFriendsData()
        }
    }
}

//struct FriendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendsView()
//    }
//}

struct LazyView<Content: View>: View {

    private let content: () -> Content

    init(_ content: @autoclosure @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        self.content()
    }
}
