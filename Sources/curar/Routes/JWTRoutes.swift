//
//  JWTRoutes.swift
//  curar
//
//  Created by jack Maarek on 08/07/2019.
//

import Foundation
import KituraContracts
import SwiftJWT

func initializeJWTRoutes(app: App){
    //Send JWT
    app.router.post("/jwtlogin"){ request, response, next in
        let credentials = try request.read(as: UserCredentials.self)
        let myClaims = ClaimsStandardJWT(iss: "Users", sub: credentials.username + credentials.password, exp: Date(timeIntervalSinceNow: 3600))
        var myJwt = JWT(claims: myClaims)
        let signedJWT = try myJwt.sign(using: App.jwtSigner)
        response.send(signedJWT)
        next()
    }
    
    //Retrieve JWT
    app.router.get("/jwtprotected"){ request, response, next in
        let authHeader = request.headers["Authorization"]
        guard let authComponents = authHeader?.components(separatedBy : " "),
            authComponents.count == 2,
            authComponents[0] == "Bearer",
            let jwt = try? JWT<ClaimsStandardJWT>(jwtString: authComponents[1], verifier: App.jwtVerifier)
            else {
                let _ = response.send(status: .unauthorized)
                return try response.end()
        }
        response.send(jwt)
        next()
    }
    
    app.router.get("/jwtCodable", handler: app.typeSafeHandler)
}

extension App{
    static let jwtSigner = JWTSigner.hs256(key: Data("kitura".utf8))
    static let jwtVerifier = JWTVerifier.hs256(key: Data("kitura".utf8))
}
