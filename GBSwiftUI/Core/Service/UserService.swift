//
//  UserService.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 31.03.2022.
//

import Foundation
import Combine

protocol UserServiceProtocolInput: AnyObject {
    func getFriends() -> AnyPublisher<[User], Error>
}

final class UserService: UserServiceProtocolInput {
    
    let baseURL = "https://api.vk.com/method"
    let token = UserDefaults.standard.object(forKey: "vkToken") as? String
    let clientID = UserDefaults.standard.object(forKey: "userId") as? String
    let version = "5.131"
    
    func getFriends() -> AnyPublisher<[User], Error> {
        
        let urlString = baseURL + "/friends.get"
        
        guard var components = URLComponents(string: urlString) else {
            return Fail(error: NetworkError.default).eraseToAnyPublisher()
        }
        
        components.queryItems = [
            URLQueryItem(name: "user_id", value: clientID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "fields", value: "city, photo_100"),
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
            .decode(type: UsersResponse.self, decoder: JSONDecoder())
            .map { $0.response.items}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
