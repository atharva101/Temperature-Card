import * as CryptoJS from 'crypto-js';
import { Constant } from './constants';

export const encrypt = (msg: string) => {
    // random salt for derivation
    var key = CryptoJS.enc.Utf8.parse(Constant.encryptionKey);
    var iv = CryptoJS.enc.Utf8.parse(Constant.encryptionKey);
    var encrypted = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(msg), key,
        {
            keySize: 128 / 8,
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });

    // var decrypted = CryptoJS.AES.decrypt(encrypted, key, {
    //     keySize: 128 / 8,
    //     iv: iv,
    //     mode: CryptoJS.mode.CBC,
    //     padding: CryptoJS.pad.Pkcs7
    // });
    return encrypted.toString();
}