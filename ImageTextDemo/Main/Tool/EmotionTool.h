//
//  EmotionTool.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
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
