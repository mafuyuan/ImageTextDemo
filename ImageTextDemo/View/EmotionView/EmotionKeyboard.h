//
//  EmotionKeyboard.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2016/12/30.
//  Copyright © 2016年 佳思德Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionKeyboard : UIView

@property (nonatomic, strong) NSArray *emotions;

+ (instancetype)keyboard;

@end
