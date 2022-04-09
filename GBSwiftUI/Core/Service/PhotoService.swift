//
//  PhotoService.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 30.03.2022.
//

import Foundation
import Combine

protocol APIServiceProtocol: AnyObject {
    func getPhotos(userId: Int) -> AnyPublisher<[Photo], Error>
}

enum NetworkError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectUrl
    case `default`
}

final class PhotoService: APIServiceProtocol {
    
    let baseURL = "https://api.vk.com/method"
    let token = UserDefaults.standard.object(forKey: "vkToken") as? String
    let clientID = UserDefaults.standard.object(forKey: "userId") as? String
    let version = "5.131"
    
    func getPhotos(userId: Int) -> AnyPublisher<[Photo], Error> {
        
        let urlString = baseURL + "/photos.get"
        
        guard var components = URLComponents(string: urlString) else {
            return Fail(error: NetworkError.default).eraseToAnyPublisher()
        }
        
        components.queryItems = [
            URLQueryItem(name: "owner_id", value: String(userId)),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "extended", value: "0"),
            URLQueryItem(name: "count", value: "25"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = components.url else {
            return Fail(error: NetworkError.default).eraseToAnyPublisher()
        }
        
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 20
        )
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map {
                $0.data
            }
            .decode(type: PhotoResponse.self, decoder: JSONDecoder())
            .map {
                $0.response.items
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
