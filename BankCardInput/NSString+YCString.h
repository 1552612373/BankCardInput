//
//  NSString+YCString.h
//  BankCardInput
//
//  Created by YC on 2020/7/30.
//  Copyright © 2020 yc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YCString)

/// 给卡号每4位加一个空格
- (NSString *)cardNumberAddSpace;

@end

NS_ASSUME_NONNULL_END
