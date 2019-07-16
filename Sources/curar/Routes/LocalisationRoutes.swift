//
//  UsersRoutes.swift
//  curar
//
//  Created by jack Maarek on 08/07/2019.
//

import CouchDB
import Kitura
import KituraContracts
import LoggerAPI
import SwiftJWT


private var database: Database?

func initializeLocalisationRoutes(app: App){
    database = app.database
    
    app.router.get("/locations", handler: getLocations)
    app.router.post("/locations", handler: addLocation)
    app.router.post("/erase_locations", handler: deleteLocation)
    
}

// Get Locations Handler
private func getLocations(completion: @escaping ([Location]?, RequestError?) -> Void ){
    guard let database =  database else {
        return completion(nil, .internalServerError)
    }
    Location.Persistance.getAll(from: database){ location, error in
        return completion(location, error as? RequestError)
        
    }
    
}

private func addLocation(location: Location, completion: @escaping (Location?, RequestError?) -> Void){
    guard let database =  database else {
        return completion(nil, .internalServerError)
    }
    Location.Persistance.save(location, to: database){ newLocation, error in
        return completion(newLocation, error as? RequestError)
    }
}

private func deleteLocation(id: String, completion: @escaping (_ id:String, RequestError?) -> Void){
    guard let database =  database else {
        return completion(id, .internalServerError)
    }
    Location.Persistance.delete(id, from: database){ error in
        return completion(id, error as? RequestError)
    }
}
