//
//  NSString+YCString.m
//  BankCardInput
//
//  Created by YC on 2020/7/30.
//  Copyright © 2020 yc. All rights reserved.
//

#import "NSString+YCString.h"

@implementation NSString (YCString)

/// 给卡号每4位加一个空格
- (NSString *)cardNumberAddSpace {
    NSString *selfString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    for (int i = 0; i < selfString.length; i = i+4) {
        newString = [newString stringByAppendingString:[selfString substringWithRange:NSMakeRange(i, MIN(4, selfString.length-i))]];
        if (i+4 < selfString.length) {
            newString = [newString stringByAppendingString:@" "];
        }
    }
    return newString;
}

@end
