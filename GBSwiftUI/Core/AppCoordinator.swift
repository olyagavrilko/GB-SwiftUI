//
//  AppCoordinator.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 15.04.2022.
//

import SwiftUI

final class AppCoordinator {
                
    let tabBarViewController: UITabBarController
    
    let window: UIWindow
    
    init(window: UIWindow, tabBarViewController: UITabBarController) {
        self.window = window
                
        let friendsViewController = UIHostingController(rootView: FriendsView(viewModel: FriendsViewModel(userService: UserService(), realmManager: RealmManager()!)))
        let groupsViewController = UIHostingController(rootView: GroupsView(viewModel: GroupsViewModel(groupService: GroupService())))
        let newsViewController = UIHostingController(rootView: NewsView())
        
        
        self.tabBarViewController = tabBarViewController
        self.tabBarViewController.viewControllers = [
            setupTab(for: friendsViewController, title: "Friends", image: UIImage(systemName: "person.2")!),
            setupTab(for: groupsViewController, title: "Groups", image: UIImage(systemName: "person.3")!),
            setupTab(for: newsViewController, title: "News", image: UIImage(systemName: "newspaper")!),
        ]
    }
    
    public func start() {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let loginView = LoginView()
//            .environment(\.managedObjectContext, context)
        
        if UserDefaults.standard.object(forKey: "vkToken") != nil {
            self.window.rootViewController = self.tabBarViewController
        } else {
            self.window.rootViewController = UIHostingController(rootView: LoginView())
        }
    }
    
    func setupTab(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        rootViewController.tabBarItem.title = title
        rootViewController.tabBarItem.image = image
        return rootViewController
    }
}
