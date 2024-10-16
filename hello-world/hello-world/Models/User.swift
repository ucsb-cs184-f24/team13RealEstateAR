//
//  User.swift
//  hello-world
//
//  Created by Animesh on 16/10/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
