//
//  UserCell.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 23.03.2022.
//

import SwiftUI

struct UserCell: View {

    var body: some View {
        VStack {
            SettingRow(imageName: "VKLogo") {
                VStack(alignment: .leading) {
                    Text("VK")
                        .titleStyle
                    Text("Description")
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
    static var previews: some View {
        UserCell()
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
