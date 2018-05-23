//
//  EmotionAttachment.m
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//

#import "EmotionAttachment.h"
#import "Emotion.h"
@implementation EmotionAttachment
- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}
@end
