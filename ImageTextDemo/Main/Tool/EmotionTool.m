//
//  EmotionTool.m
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
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
