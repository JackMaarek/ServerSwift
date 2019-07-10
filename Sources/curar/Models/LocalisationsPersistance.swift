//
//  UsersPersistance.swift
//  curar
//
//  Created by jack Maarek on 08/07/2019.
//
import Foundation
import CouchDB
import LoggerAPI

extension Location {
    class Persistance{
        
        static func getAll(from database: Database, callback:
            @escaping(_ Location: [Location]?, _ error: Error?) -> Void){
            database.retrieveAll(includeDocuments: true){ documents, error in
                guard let documents = documents else{
                    Log.error("Error retrieving all documents: \(String(describing: error))")
                    return callback(nil, error)
            }
                let Locations = documents.decodeDocuments(ofType: Location.self)
                callback(Locations, nil)
        }
    }
        
        static func save(_ location: Location, to database: Database, callback:
            @escaping(_ location: Location?, _ error: Error?) -> Void){
            database.create(location){ document, error in
                guard let document = document else{
                    Log.error("Error creating new user: \(String(describing: error))")
                    return callback(nil, error)
                }
                database.retrieve(document.id, callback: callback)
            }
            
        }
        
        static func delete(_ locationID: String, from database: Database, callback:
            @escaping(_ error: Error?)-> Void){
            database.retrieve(locationID) { (location: Location?, error: CouchDBError?) in
                guard let location = location, let locationRev = location._rev else{
                    Log.error("Error creating new document: \(String(describing: error))")
                    return callback(error)
                }
                database.delete(locationID, rev: locationRev, callback: callback)
            }
        }
        
        
    }
}
