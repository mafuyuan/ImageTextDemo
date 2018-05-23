//
//  EmotionTool.m
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import "EmotionTool.h"
#import "Emotion.h"
@implementation EmotionTool

static NSArray *_trafficSigns;

+ (NSArray *)trafficSigns{
    if (!_trafficSigns) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/trafficSign/signInfo.plist" ofType:nil];
        _trafficSigns = [Emotion mj_objectArrayWithFile:plist];
        [_trafficSigns makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/trafficSign"];
    }
    return _trafficSigns;
}

+ (Emotion *)emotionWithDesc:(NSString *)desc
{
    if (!desc) return nil;
    __block Emotion *foundEmotion = nil;
    // 从交通标志表情中查找
    [[self trafficSigns] enumerateObjectsUsingBlock:^(Emotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    return foundEmotion;
}

@end
