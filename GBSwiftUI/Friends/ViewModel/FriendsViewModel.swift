//
//  FriendsViewModel.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 30.03.2022.
//

import Foundation
import Combine
import RealmSwift

final class FriendsViewModel: ObservableObject {
    
    @Published private(set) var friends: [User] = []
    @Published var isErrorAlertShown: Bool = false
    
    private let userService: UserServiceProtocolInput
    private let realmManager: RealmManagerProtocolInput
    private var friendRequest: AnyCancellable?
        
    private(set) var errorMessage: String?
    
    init(userService: UserServiceProtocolInput, realmManager: RealmManagerProtocolInput) {
        self.userService = userService
        self.realmManager = realmManager
    }
    
    func getFriendsData() {
        
        friends = getCachedFriends()
        
        friendRequest = userService.getFriends()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isErrorAlertShown = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] users in
                try? self?.realmManager.add(object: users, update: .all)
                self?.friends = users
            }
    }
    
    //MARK: - Private
    
    private func getCachedFriends() -> [User] {
        let friends = try? realmManager.getObjects(type: User.self)
        return friends?.map { $0.detached() } ?? []
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

