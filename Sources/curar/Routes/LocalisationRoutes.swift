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
    app.router.post("/locations", handler: deleteLocation)
    
    
}
