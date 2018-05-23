//
//  EmotionTextView.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emotion;
@interface EmotionTextView : UITextView

- (void)appendEmotion:(Emotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;

@end
