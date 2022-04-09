//
//  GroupsView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 29.03.2022.
//

import SwiftUI

struct GroupsView: View {
    
    @ObservedObject var viewModel: GroupsViewModel
    
    init(viewModel: GroupsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.groups) { group in
                GroupRow(groupName: group.name, description: group.activity ?? "", imageURL: group.photo100)
            }
            .listStyle(.plain)
            .navigationTitle(Text("Мои сообщества"))
            .onAppear {
                viewModel.getGroupsData()
            }
        }
    }
}

//struct GroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupsView()
//    }
//}
