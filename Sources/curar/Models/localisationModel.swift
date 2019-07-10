//
//  UsersModel.swift
//  curar
//
//  Created by jack Maarek on 08/07/2019.
//

import CouchDB

struct Location : Document {
    let _id: String?
    var _rev: String?
    var username: String?
    var identifierRole: String?
    var coordinate: [Coordinate]?
    
}

struct Coordinate : Codable {
    let latitude: Double?
    let longitude: Double?
}
