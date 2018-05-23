//
//  Emtion.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface Emotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *cht;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;
/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;
/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;
@end
