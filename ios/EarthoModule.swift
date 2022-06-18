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
        resolve: @escaping RCTPromiseResolveBlock,
        reject:@escaping RCTPromiseRejectBlock) -> Void {
                 let earthoOne = EarthoOne()
            earthoOne.connectWithPopup(
            accessId: accessId,
            onSuccess: { credentials in
                 do {
                     let data = EarthoCredentials( tokenType: credentials.tokenType, expiresIn: credentials.expiresIn, refreshToken: credentials.refreshToken, idToken: credentials.idToken, scope: credentials.scope, recoveryCode: credentials.recoveryCode
                     )
                     let encoder = JSONEncoder()
                     let json = try encoder.encode(data)
                     let result = String(data: json, encoding: .utf8)!
                     resolve(result)
                 } catch {
                     reject("ConnectFailure", "Failure Connect With EarthoOne", nil)
                 }
            },
            onFailure: { WebAuthError in
                reject("ConnectFailure", "Failure Connect With EarthoOne", WebAuthError)
            })
    }

    @objc(getIdToken:withResolver:withRejecter:)
    func getIdToken(
        a:String,
        resolve:RCTPromiseResolveBlock,
        reject:RCTPromiseRejectBlock) -> Void {
    
            resolve(earthoOne.getIdToken())
    }

    @objc(getUser:withResolver:withRejecter:)
    func getUser(
        a:String,
        resolve:RCTPromiseResolveBlock,
        reject:RCTPromiseRejectBlock) -> Void {
        
            do {
                       let credentials = earthoOne.getUser();
                       guard credentials != nil else {
                           resolve(nil)
                           return
                       }

                       let dataa = UserResult(uid: credentials?.uid as! String, displayName: credentials?.displayName as? String, email: credentials?.email as? String, photoURL: credentials?.photoURL as? String, firstName: credentials?.firstName as? String, lastName: "", phone: "")
                       let encoder = JSONEncoder()
                       let json = try encoder.encode(dataa)
                       let result = String(data: json, encoding: .utf8)!
                resolve(result)
                   } catch {
                       reject("GetUserFailure", "Failure Get User Data", error)
                   }
    }

    @objc(disconnect:withResolver:withRejecter:)
    func disconnect(
        a:String,
        resolve:RCTPromiseResolveBlock,
        reject:RCTPromiseRejectBlock) -> Void {
        earthoOne.logout();
        resolve("")
    }
    
    struct EarthoCredentials: Codable {
           var tokenType: String?
           var expiresIn: Date?
           var refreshToken: String?
           var idToken: String?
           var scope: String?
           var recoveryCode: String?
       }
       
       struct UserResult: Codable {
           var uid: String?
           var displayName: String?
           var email: String?
           var photoURL: String?
           var firstName: String?
           var lastName: String?
           var phone: String?
       }
}
