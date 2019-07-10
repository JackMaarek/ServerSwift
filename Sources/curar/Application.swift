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
        
        let connectionProperties = ConnectionProperties(host: "localhost", port: 5984, secured: false,username: "CurarDB", password: "CurarPass" )
        client = CouchDBClient(connectionProperties: connectionProperties)
        client!.retrieveDB("Locations"){ database, error in
            guard let database = database else {
                Log.info("Could not retrieve Location database :"
                    + "\(String(describing: error?.localizedDescription))"
                    + "- attempting to create new one")
                self.createNewDatabase()
                return
            }
            Log.info("Locations database located - loading...")
            self.finalizeRoutes(with: database)
        }
        
    }
    
    func connectionToDatabase() {
        let connectionProperties = ConnectionProperties(host: "localhost", port: 5984, secured: false, username: "CurarDB", password: "CurarPass" )
        client = CouchDBClient(connectionProperties: connectionProperties)
        client!.retrieveDB("Locations"){ database, error in
            guard let database = database else {
                Log.info("Could not retrieve Location database :"
                    + "\(String(describing: error?.localizedDescription))"
                    + "- attempting to create new one")
                self.createNewDatabase()
                return
            }
            Log.info("Locations database located - loading...")
            self.finalizeRoutes(with: database)
        }
    }
    
    private func createNewDatabase(){
        client?.createDB("Location"){ database, error in
            guard let database = database else{
                Log.error("Could not create database"
                    + "(\(String(describing: error?.localizedDescription))"
                    + "- Locations database not created")
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
