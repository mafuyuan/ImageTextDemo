//
//  EmotionTextView.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
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
