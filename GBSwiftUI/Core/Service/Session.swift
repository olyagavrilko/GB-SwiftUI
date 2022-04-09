//
//  Session.swift
//  GBSwiftUI
//
//  Created by Olya Ganeva on 30.03.2022.
//

import Foundation

final class Session {

    static let shared = Session()

    private init() {}

    var token = ""
    var userId = ""
}
