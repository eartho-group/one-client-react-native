#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(EarthoModule, NSObject)

RCT_EXTERN_METHOD(initEartho:(NSString)clientId 
                 withB:(NSString)clientSecret
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(connectWithRedirect:(NSString)accessId
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
@end
