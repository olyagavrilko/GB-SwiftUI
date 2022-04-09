//
//  GroupsViewModel.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 05.04.2022.
//

import Foundation
import Combine

final class GroupsViewModel: ObservableObject {
    
    @Published private(set) var groups: [Group] = []
    
    private let groupService: GroupServiceProtocolInput
    private var groupRequest: AnyCancellable?
    
    private(set) var errorMessage: String?
    
    init(groupService: GroupServiceProtocolInput) {
        self.groupService = groupService
    }
    
    func getGroupsData() {
                
        groupRequest = groupService.getGroups()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] groups in
                self?.groups = groups
            }
    }
}
