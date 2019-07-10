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
        
        static func save(_ Location: Location, to database: Database, callback:
            @escaping(_ Location: Location?, _ error: Error?) -> Void){
            database.create(Location){ Location, error in
                guard let Location = Location else{
                    Log.error("Error creating new user: \(String(describing: error))")
                    return callback(nil, error)
                }
                database.retrieve(Location.id, callback: callback)
            }
            
        }
        
        static func delete(_ LocationID: String, from database: Database, callback:
            @escaping(_ error: Error?)-> Void){
            database.retrieve(LocationID) { (Location: Location?, error: CouchDBError?) in
                guard let Location = Location, let LocationRev = Location._rev else{
                    Log.error("Error creating new document: \(String(describing: error))")
                    return callback(error)
                }
                database.delete(LocationID, rev: LocationRev, callback: callback)
            }
        }
        
        
    }
}
