//
//  User.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 31.03.2022.
//

import Foundation
import RealmSwift

// MARK: - Welcome
struct UsersResponse: Decodable {
    let response: InternalUsersResponse
}

// MARK: - Response
struct InternalUsersResponse: Decodable {
    let count: Int
    let items: [User]
}

// MARK: - Item
class User: Object, Decodable, Identifiable {
//    @Persisted вместо @objc dynamic
    @objc dynamic var firstName = ""
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var city: City?

    let photos = List<Photo>()

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo100 = "photo_100"
        case city
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

// MARK: - City
class City: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
}

