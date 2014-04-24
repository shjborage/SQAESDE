//
//  SQAESDE.h
//
//  Created by Eric on 8/30/12.
//  Copyright (c) 2012 Inforwave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQAESDE : NSObject

+ (NSString *)enCrypt:(NSString *)strContent key:(NSString *)strKey;
+ (NSString *)deCrypt:(NSString *)strContent key:(NSString *)strKey;

+ (NSString *)enCryptBase64:(NSString *)strContent key:(NSString *)strKey;
+ (NSString *)deCryptBase64:(NSString *)strContent key:(NSString *)strKey;

@end
