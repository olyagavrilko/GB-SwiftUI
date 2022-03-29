//
//  GroupRow.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 23.03.2022.
//

import SwiftUI

struct GroupRow: View {

    var body: some View {
        VStack {
            SettingRow(imageName: "VKLogo") {
                VStack(alignment: .leading) {
                    Text("VK")
                        .titleStyle()
                    Text("Description")
                        .subtitleStyle()
                }
            }
        }
    }
}

struct GroupCell_Previews: PreviewProvider {
    static var previews: some View {
        GroupRow()
    }
}
