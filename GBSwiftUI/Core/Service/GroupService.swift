//
//  GroupService.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 05.04.2022.
//

import Foundation
import Combine

protocol GroupServiceProtocolInput: AnyObject {
    func getGroups() -> AnyPublisher<[Group], Error>
}

final class GroupService: GroupServiceProtocolInput {
    
    let baseURL = "https://api.vk.com/method"
    let token = UserDefaults.standard.object(forKey: "vkToken") as? String
    let clientID = UserDefaults.standard.object(forKey: "userId") as? String
    let version = "5.131"
    
    func getGroups() -> AnyPublisher<[Group], Error> {
        
        let urlString = baseURL + "/groups.get"
        
        guard var components = URLComponents(string: urlString) else {
            return Fail(error: NetworkError.default).eraseToAnyPublisher()
        }
        
        components.queryItems = [
            URLQueryItem(name: "user_id", value: clientID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
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
            .decode(type: GroupsResponse.self, decoder: JSONDecoder())
            .map { $0.response.items}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
