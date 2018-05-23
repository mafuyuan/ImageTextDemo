//
//  EmotionTool.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//
#import <Foundation/Foundation.h>
@class Emotion;
@interface EmotionTool : NSObject
/**
 *  交通标记
 */
+ (NSArray *)trafficSigns;
/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (Emotion *)emotionWithDesc:(NSString *)desc;
@end
