//
//  DecoderTool.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface DecoderTool : NSObject
MSingletonH(DecoderTool)
- (NSMutableAttributedString *)decodeWithPlainStr:(NSString *)plainStr font:(UIFont *)font textColor:(UIColor *)textColor;
@end
