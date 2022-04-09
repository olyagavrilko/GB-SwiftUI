//
//  ContainerView.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 24.03.2022.
//

import SwiftUI

struct ContainerView: View {

    @State private var shouldShowMainView: Bool = false

    var body: some View {
        
        if UserDefaults.standard.object(forKey: "vkToken") != nil {
            
            TabView {
                NavigationView {
                    FriendsView(viewModel: FriendsViewModel(userService: UserService(), realmManager: RealmManager()!))
                }
                .tabItem {
                    Label("Friends", systemImage: "person.2")
                }
                GroupsView(viewModel: GroupsViewModel(groupService: GroupService()))
                    .tabItem {
                        Label("Groups", systemImage: "person.3")
                    }
                
                NewsView()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
            }
        } else {
            LoginView()
            
            if UserDefaults.standard.object(forKey: "vkToken") != nil {
                
                TabView {
                    NavigationView {
                        FriendsView(viewModel: FriendsViewModel(userService: UserService(), realmManager: RealmManager()!))
                    }
                    .tabItem {
                        Label("Friends", systemImage: "person.2")
                    }
                    GroupsView(viewModel: GroupsViewModel(groupService: GroupService()))
                        .tabItem {
                            Label("Groups", systemImage: "person.3")
                        }
                    
                    NewsView()
                        .tabItem {
                            Label("News", systemImage: "newspaper")
                        }
                }
            }
        }
    }
}
