//
//  StringUtil.h
//
//  Created by shjborage on 20111106.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (NSStringUtils)
- (NSString *)encodeAsURIComponent;
- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;
+ (NSString *)localizedString:(NSString *)key;
+ (NSString *)base64encode:(NSString*)str;
- (NSString *)toUnicode;                // add by shjborage 20111106.
+ (NSString *)getUUID;                  // add by shjborage Jan 24, 2012
+ (NSString *)getCurrentDateTime:(NSString *)strFormat;
                                        // modify by shjborage Mar 29, 2012
- (int)charNumber;                      // add by shjborage Feb 5, 2012
- (NSString *)useAsFileName;            // add by shjborage Apr 18, 2012

+ (NSString *)getTimestamp;             // add by shjborage May 25, 2012(from IWVideoLottery by bin Liu)
- (NSDateComponents *)getDateComponents:(NSString *)strFormat;  // add by shjborage Jun 1, 2012
@end


