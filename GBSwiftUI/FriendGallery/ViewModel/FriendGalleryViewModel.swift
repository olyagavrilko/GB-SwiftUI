//
//  FriendGalleryViewModel.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 30.03.2022.
//

import Foundation
import Combine
import UIKit

final class FriendGalleryViewModel: ObservableObject {
    
    @Published private(set) var photos: [Photo] = []
    
    var title: String {
        user.firstName + user.lastName
    }
    
    private let photoService: PhotoService
    private let user: User
    private var photoRequest: AnyCancellable?
    
    private(set) var errorMessage: String?
    
    init(photoService: PhotoService, user: User) {
        self.photoService = photoService
        self.user = user
    }
    
    func getPhotosData() {
        
        photoRequest = photoService.getPhotos(userId: user.id)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] photos in
                self?.photos = photos
            }
    }
}
