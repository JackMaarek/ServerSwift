//
//  TypeSafeJWT.swift
//  CHTTPParser
//
//  Created by jack Maarek on 09/07/2019.
//

import SwiftJWT
import Kitura
// TypeSafe structure to retrieve jwt
struct TypeSafeJWT<C: Claims>: TypeSafeMiddleware {
    let jwt: JWT<C>
    static func handle(request: RouterRequest, response: RouterResponse, completion: @escaping (TypeSafeJWT?, RequestError?) -> Void) {
        let authHeader = request.headers["Authorization"]
        guard let authComponents = authHeader?.components(separatedBy: " "),
            authComponents.count == 2,
            authComponents[0] == "Bearer",
            let jwt = try? JWT<C>(jwtString: authComponents[1], verifier: App.jwtVerifier)
            else {
                return completion(nil, .unauthorized)
        }
        completion(TypeSafeJWT(jwt: jwt), nil)
    }
}
