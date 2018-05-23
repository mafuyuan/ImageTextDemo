//
//  EmotionAttachment.m
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
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
