//
//  UserRow.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 23.03.2022.
//

import SwiftUI

struct UserRow: View {

    let userName: String
    let city: String
    let imageName: String

    var body: some View {
        VStack {
            SettingRow(imageName: imageName) {
                VStack(alignment: .leading) {
                    Text(userName)
                        .titleStyle
                    Text(city)
                        .subtitleStyle
                }
            }
        }
    }
}

struct SettingRow<Content: View>: View {

    let imageName: String
    let content: Content

    init(imageName: String, @ViewBuilder content: () -> Content) {
        self.imageName = imageName
        self.content = content()
    }

    var body: some View {
        HStack {
            CircleImage(imageName: imageName)
            content
            Spacer()
        }
        .padding()
    }
}

struct TitleStyleViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundColor(.black)
    }
}

struct SubtitleStyleViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundColor(.gray)
    }
}

struct UserCell_Previews: PreviewProvider {

    static let someFriend = User(id: "some", name: "some", city: "some", photo: "VKLogo")

    static var previews: some View {
        UserRow(userName: someFriend.name, city: someFriend.city, imageName: someFriend.photo)
    }
}

extension View {

    var titleStyle: some View {
        modifier(TitleStyleViewModifier())
    }

    var subtitleStyle: some View {
        modifier(SubtitleStyleViewModifier())
    }
}
