//
//  GBRSAUtils.m
//  GrowthbeatCore
//
//  Created by Kataoka Naoyuki on 2014/07/25.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "GBRSAUtils.h"
#import <Security/Security.h>

@implementation GBRSAUtils

+ (NSString *)encrypt:(NSString *)dataString publicKey:(NSString *)base64EncodedPublicKey {
    
    SecKeyRef publicKey = [self getPublicKey:base64EncodedPublicKey];
    if(publicKey == NULL)
        return nil;
    
    size_t blockSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherTextBuffer = malloc(sizeof(uint8_t) * blockSize);
    memset(cipherTextBuffer, 0, sizeof(uint8_t) * blockSize);
    
    size_t cipherTextLength = blockSize;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    OSStatus result = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, (const uint8_t *)[data bytes], [data length], cipherTextBuffer, &cipherTextLength);
    
    NSData *encryptedData = nil;
    if (result == errSecSuccess)
        encryptedData = [NSData dataWithBytes:cipherTextBuffer length:cipherTextLength];
    free(cipherTextBuffer);
    
    return [encryptedData base64Encoding];
    
}

+ (SecKeyRef)getPublicKey:(NSString *)base64EncodedPublickKey {
    
    NSData* publicKeyData = [[NSData alloc] initWithBase64Encoding:base64EncodedPublickKey];
    unsigned char *publicKeyBytes = (unsigned char *)[publicKeyData bytes];
    
    size_t index = 24;
    if([publicKeyData length] <= index)
        return NULL;
    if(publicKeyBytes[0] != 0x30 || publicKeyBytes[4] != 0x30 || publicKeyBytes[19] != 0x03 || publicKeyBytes[23] != 0x00)
        return NULL;
    NSData *extractedPublicKeyBytes = [NSData dataWithBytes:&publicKeyBytes[index] length:[publicKeyData length] - index];
    
    NSString *applicationTagString = @"com.GrowthbeatCore.publickey";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [attributes setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [attributes setObject:[applicationTagString dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecAttrApplicationTag];
    [attributes setObject:extractedPublicKeyBytes forKey:(__bridge id)kSecValueData];
    [attributes setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];
    [attributes setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    
    CFTypeRef result = NULL;
    SecItemDelete((__bridge CFDictionaryRef)attributes);
    SecItemAdd((__bridge CFDictionaryRef)attributes, (CFTypeRef *)&result);
    if (result == NULL)
        return NULL;
    CFRelease(result);
    
    SecKeyRef publicKey = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)attributes, (CFTypeRef *)&publicKey);
    SecItemDelete((__bridge CFDictionaryRef)attributes);
    
    return publicKey;
    
}


@end
