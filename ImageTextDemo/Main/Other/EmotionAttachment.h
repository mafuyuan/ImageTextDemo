//
//  EmotionAttachment.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emotion;
@interface EmotionAttachment : NSTextAttachment
@property (nonatomic, strong) Emotion *emotion;
@property(nonatomic, strong) NSString *emojiTag;

@end
