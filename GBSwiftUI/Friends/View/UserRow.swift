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
    let imageURL: String

    var body: some View {
        VStack {
            SettingRow(imageURL: imageURL) {
                VStack(alignment: .leading) {
                    Text(userName)
                        .titleStyle()
                    Text(city)
                        .subtitleStyle()
                }
            }
        }
    }
}

struct SettingRow<Content: View>: View {

    let imageURL: String
    let content: Content

    init(imageURL: String, @ViewBuilder content: () -> Content) {
        self.imageURL = imageURL
        self.content = content()
    }

    var body: some View {
        
        let url = URL(string: imageURL)
        
        HStack {
            CircleImage(imageURL: url!)
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

//struct UserCell_Previews: PreviewProvider {
//
//    static let someFriend = User(id: "some", name: "some", city: "some", photo: "VKLogo")
//
//    static var previews: some View {
//        UserRow(userName: someFriend.name, city: someFriend.city, imageName: someFriend.photo)
//    }
//}

extension View {

    func titleStyle() -> some View {
        modifier(TitleStyleViewModifier())
    }

    func subtitleStyle() -> some View {
        modifier(SubtitleStyleViewModifier())
    }
}
