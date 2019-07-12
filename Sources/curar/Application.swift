//
//  Application.swift
//  curar
//
//  Created by jack Maarek on 08/07/2019.
//

import Foundation
import CouchDB
import Kitura
import LoggerAPI
import SwiftJWT


public class App{
    var client: CouchDBClient?
    var database: Database?
    let router = Router()
    
    private func postInit() {
        initializeJWTRoutes(app: self)
        connectionToDatabase()
    }
    
    
    private func connectionToDatabase() {
        let connectionProperties = ConnectionProperties(host: "localhost", port: 5984, secured: false)
        client = CouchDBClient(connectionProperties: connectionProperties)
        client!.retrieveDB("locations"){ database, error in
            guard let database = database else {
                Log.info("Could not retrieve Location dabase :"
                    + "\(String(describing: error?.localizedDescription))"
                    + "- attempting to create new one.")
                self.createNewDatabase()
                return
            }
            Log.info("Locations database locates - loading...")
            self.finalizeRoutes(with: database)
            
        }
    }
    
    private func createNewDatabase(){
        client?.createDB("locations") { database, error in
            guard let database = database else {
                Log.error("Could not create new database: "
                    + "(\(String(describing: error?.localizedDescription)) "
                    + "- Location routes not created")
                return
            }
            self.finalizeRoutes(with: database)
        }
    }
    
    private func finalizeRoutes(with database: Database){
        self.database = database
        initializeLocalisationRoutes(app: self)
        Log.info("Locations route created")
    }
    
    public func run(){
        postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }

}
