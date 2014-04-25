//
//  SQAESDESpec.m
//  Demo
//
//  Created by shihaijie on 4/25/14.
//  Copyright 2014 Saick. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "SQAESDE.h"


SPEC_BEGIN(SQAESDESpec)

describe(@"SQAESDE", ^{
  context(@"When asdf encrypt->decrypt", ^{
    NSString *origin = @"asdf";
    NSString *key = @"!@A";
    
    it(@"should equal to 'asdf'", ^{
      NSString *encrypt = [SQAESDE enCryptBase64:origin key:key];
      [[encrypt should] equal:@"akRajKuKvB3wHHnHFNnXtw=="];
      
      NSString *result = [SQAESDE deCryptBase64:encrypt key:key];
      [[result should] equal:origin];
    });
  });
});

SPEC_END
