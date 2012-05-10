//
//  StringUtil.m
//
//  Created by shjborage on 20111106.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQStringUtils.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"; 

@implementation NSString (NSStringUtils)

- (NSString*)encodeAsURIComponent
{
	const char* p = [self UTF8String];
	NSMutableString* result = [NSMutableString string];
	
	for (;*p ;p++) {
		unsigned char c = *p;
		if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '-' || c == '_') {
			[result appendFormat:@"%c", c];
		} else {
			[result appendFormat:@"%%%02X", c];
		}
	}
	return result;
}

+ (NSString*)base64encode:(NSString*)str 
{
    if ([str length] == 0)
        return @"";

    const char *source = [str UTF8String];
    int strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;

    NSUInteger length = 0;
    NSUInteger i = 0;

    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] autorelease];
}

- (NSString*)escapeHTML
{
	NSMutableString* s = [NSMutableString string];
	
	int start = 0;
	int len = [self length];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}

- (NSString*)unescapeHTML
{
	NSMutableString* s = [NSMutableString string];
	NSMutableString* target = [[self mutableCopy] autorelease];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	
	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[s appendString:target];
			break;
		}
		
		if (r.location > 0) {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
		
		if ([target hasPrefix:@"&lt;"]) {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&gt;"]) {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&quot;"]) {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		} else if ([target hasPrefix:@"&amp;"]) {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
	
	return s;
}

+ (NSString *)localizedString:(NSString*)key
{
    return NSLocalizedString(key, nil);
}

- (NSString *)toUnicode
{
//    NSStringEncoding enc_gb2312 = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    char* temp = (char*)[[NSString stringWithString:target] cStringUsingEncoding:NSUnicodeStringEncoding];
//    return [NSString stringWithCString:temp encoding:NSUnicodeStringEncoding];
    NSMutableString* target = [[self mutableCopy] autorelease];
    NSData *tmp_data = [target dataUsingEncoding:NSUnicodeStringEncoding];
    NSString *tmp_ret = [[[NSString alloc] initWithData:tmp_data encoding:NSUnicodeStringEncoding] autorelease];
    return tmp_ret;
}

+ (NSString *)getUUID
{
    CFUUIDRef     UUID;
    CFStringRef   UUIDString;
    char          buffer[100];
    memset(buffer, 0, 100);
    
    UUID = CFUUIDCreate(kCFAllocatorDefault);
    UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUID);
    
    // This is the safest way to obtain a C string from a CFString.
    CFStringGetCString(UUIDString, buffer, 100, kCFStringEncodingASCII);
    CFRelease(UUIDString);
    CFRelease(UUID);
    return [NSString stringWithCString:buffer encoding:NSASCIIStringEncoding];
}

+ (NSString *)getCurrentDateTime:(NSString *)strFormat
{
/*    // string to date
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date_new = [df dateFromString:@"2012-01-24 00:11:11"];
    
    // date to dateComponets
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* today = [NSDate date];
    NSUInteger uFlag = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay |kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    NSDateComponents *dcToday = [gregorian components:uFlag fromDate:today];
 
    // other usage
    NSDate *date_now = [NSDate date];
    NSString *strDate = [date_now descriptionWithLocale:[NSLocale currentLocale]];
    return [strDate substringToIndex:[strDate rangeOfString:@"China Standard Time"].location - 1];
 */
    NSDate *date_now = [NSDate date];
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setDateFormat:strFormat];
    return [df stringFromDate:date_now];
}

/*
 *  默认的length返回 unicode长度，这个中文汉字长度为2，英文数字为1
 */
- (int)charNumber
{
    int nLength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            nLength++;
        } else {
            p++;
        }
    }
    return nLength;
}

- (NSString *)useAsFileName             // add by shjborage Apr 18, 2012
{
    NSString *strTmp = self;
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"/" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"\\" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@":" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"*" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"?" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"\"" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"<" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@">" withString:@" "];
    strTmp = [strTmp stringByReplacingOccurrencesOfString:@"|" withString:@" "];
    return strTmp;
}

@end



