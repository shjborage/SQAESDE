//
//  SQAESDE.m
//
//  Created by Eric on 8/30/12.
//  Copyright (c) 2012 Saick.net. All rights reserved.
//

#import "SQAESDE.h"
#import "NSData+SQAES256.h"
#import "NSData+SQBase64.h"

@implementation SQAESDE

+ (NSString *)enCrypt:(NSString *)strContent key:(NSString *)strKey
{
  NSData *dataContent = [strContent dataUsingEncoding:NSUTF8StringEncoding];
  NSData *dataEncrypt = [dataContent AES256EncryptWithKey:strKey];
  return [dataEncrypt toHex];
}

+ (NSString *)deCrypt:(NSString *)strContent key:(NSString *)strKey
{
  NSData *dataContent = [NSData dataFromHex:strContent];
  NSData *dataDecrypt = [dataContent AES256DecryptWithKey:strKey];
  return [[NSString alloc] initWithData:dataDecrypt encoding:NSUTF8StringEncoding];
}

+ (NSString *)enCryptBase64:(NSString *)strContent key:(NSString *)strKey
{
  NSData *dataContent = [strContent dataUsingEncoding:NSUTF8StringEncoding];
  NSData *dataEncrypt = [dataContent AES256EncryptWithKey:strKey];
  return [dataEncrypt base64EncodedString];
}

+ (NSString *)deCryptBase64:(NSString *)strContent key:(NSString *)strKey
{
  NSData *dataContent = [NSData dataFromBase64String:strContent];
  NSData *dataDecrypt = [dataContent AES256DecryptWithKey:strKey];
  return [[NSString alloc] initWithData:dataDecrypt encoding:NSUTF8StringEncoding];
}

@end
