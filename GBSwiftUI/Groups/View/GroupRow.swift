//
//  GroupRow.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 23.03.2022.
//

import SwiftUI

struct GroupRow: View {
    
    let groupName: String
    let description: String
    let imageURL: String

    var body: some View {
        VStack {
            SettingRow(imageURL: imageURL) {
                VStack(alignment: .leading) {
                    Text(groupName)
                        .titleStyle()
                    Text(description)
                        .subtitleStyle()
                }
            }
        }
    }
}

//struct GroupCell_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupRow()
//    }
//}
