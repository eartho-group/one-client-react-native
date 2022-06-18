import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-eartho-module' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const EarthoOneModule = NativeModules.EarthoModule
  ? NativeModules.EarthoModule
  : new Proxy(
    {},
    {
      get() {
        throw new Error(LINKING_ERROR);
      },
    }
  );

export function init(clientId: string, clientSecret: string): Promise<void> {
  return EarthoOneModule.init(clientId, clientSecret);
}
export function connectWithRedirect(accessId: string): Promise<string> {
  return EarthoOneModule.connectWithRedirect(accessId);
}

export function getIdToken(): Promise<string> {
  return EarthoOneModule.getIdToken();
}

export function getUser(): Promise<EarthoUser> {
  return EarthoOneModule.getUser().then(
    (userData: Map<string, any>) => userData as EarthoUser
  );
}

export function disconnect(): Promise<void> {
  return EarthoOneModule.disconnect();
}
export class EarthoUser {
  firstName?: string;
  lastName?: string;
  displayName?: string;
  photoURL?: string;
  email?: string;
  emailVerified?: boolean;
  gender?: string;
  birthdate?: string;
  zoneinfo?: string;
  locale?: string;
  phoneNumber?: string;
  updatedAt?: string;
  [key: string]: any;
}
