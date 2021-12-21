//
//  Model.swift
//  Four Square Replica
//
//  Created by Sharuk on 27/11/2021.
//  Copyright © 2021 Programmers force. All rights reserved.
//

import Foundation

// MARK: - Model for Place
//
struct Icon: Codable{
    var prefix: String?
    var suffix: String?
}

struct Category: Codable{
    var id: Int?
    var name: String?
    var icon: Icon?
}

struct Location: Codable{
    var country: String?
    var locality: String?
    var region: String?
}

struct place: Codable{
    var fsq_id: String
    var name: String
    var categories: [Category]?
    var distance: Int
    var geocodes: geocodes
    var location: Location
}

struct places: Codable {
    var results: [place]
}

struct main: Codable{
    var latitude: Double
    var longitude: Double
}

struct geocodes: Codable {
    var main: main
}
