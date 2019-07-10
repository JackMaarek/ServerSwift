import Kitura
import HeliumLogger
import LoggerAPI
import SwiftJWT

HeliumLogger.use()

    let app = App()
    app.run()

extension App{
    func typeSafeHandler(typeSafeJWT: TypeSafeJWT<ClaimsStandardJWT>, completion: (JWT<ClaimsStandardJWT>?, RequestError?) -> Void) {
        completion(typeSafeJWT.jwt, nil)
    }
}
