import EarthoOne

@objc(EarthoModule)
class EarthoModule: NSObject {
    let earthoOne = EarthoOne()

    @objc(initEartho:withB:withResolver:withRejecter:)
    func initEartho(
        clientId: String, 
        clientSecret: String, 
        resolve:RCTPromiseResolveBlock,
        reject:RCTPromiseRejectBlock) -> Void {
        
        resolve("")
    }

    @objc(connectWithRedirect:withResolver:withRejecter:)
    func connectWithRedirect(
        accessId: String, 
        resolve:RCTPromiseResolveBlock,
        reject:RCTPromiseRejectBlock) -> Void {
                 let earthoOne = EarthoOne()
earthoOne.connectWithPopup(
            accessId: accessId,
            onSuccess: { credentials in
                // do {
                //     let data = EarthoCredentials( tokenType: credentials.tokenType, expiresIn: credentials.expiresIn, refreshToken: credentials.refreshToken, idToken: credentials.idToken, scope: credentials.scope, recoveryCode: credentials.recoveryCode
                //     )
                //     let encoder = JSONEncoder()
                //     let json = try encoder.encode(data)
                //     let result = String(data: json, encoding: .utf8)!
                //     flutterResult(result)
                // } catch {
                //     flutterResult(FlutterError(code: "ConnectFailure", message: "Failure Logging In With EarthoOne", details: "Error encoding credentials"))
                // }
            },
            onFailure: { WebAuthError in
                // flutterResult(FlutterError(code: "ConnectFailure", message: "Failure connecting with EarthoOne", details: WebAuthError))
            })
    }
}
