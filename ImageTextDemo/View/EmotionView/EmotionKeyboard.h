//
//  EmotionKeyboard.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionKeyboard : UIView

@property (nonatomic, strong) NSArray *emotions;

+ (instancetype)keyboard;

@end
