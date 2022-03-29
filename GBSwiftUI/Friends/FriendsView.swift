//
//  FriendsView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 24.03.2022.
//

import SwiftUI

struct User: Identifiable {
    let id: String
    let name: String
    let city: String
    let photo: String
}

struct FriendsView: View {

    @State private var friends: [User] = [
        User(id: "0", name: "Name0", city: "City0", photo: "VKLogo"),
        User(id: "1", name: "Name1", city: "City1", photo: "VKLogo"),
        User(id: "2", name: "Name2", city: "City2", photo: "VKLogo"),
        User(id: "3", name: "Name3", city: "City3", photo: "VKLogo"),
        User(id: "4", name: "Name4", city: "City4", photo: "VKLogo"),
    ]

    var body: some View {
        List(friends) { friend in
            NavigationLink(
                destination: LazyView(FriendGalleryView(user: friend)),
                label: {
                    UserRow(userName: friend.name, city: friend.city, imageName: friend.photo)
                })
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}

struct LazyView<Content: View>: View {

    private let content: () -> Content

    init(_ content: @autoclosure @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        self.content()
    }
}
