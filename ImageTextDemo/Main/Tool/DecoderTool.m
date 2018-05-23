//
//  DecoderTool.m
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2017/1/3.
//  Copyright © 2017年 佳思德Mac. All rights reserved.
//

#import "DecoderTool.h"
#import "EmotionAttachment.h"
#import "EmotionTool.h"
#import "Emotion.h"
static CGSize                    _emotionSize;
static NSArray                   *_matches;
static NSString                  *_string;
static NSMutableArray            *_imageDataArray;
static NSArray            *_emotionArray;
static NSMutableAttributedString *_attStr;
static NSMutableAttributedString *_resultStr;

static NSString *const checkStr = @"\\{[a-zA-Z0-9\\u4e00-\\u9fa5]+\\}";

@implementation DecoderTool

MSingletonM(DecoderTool)

- (NSMutableAttributedString *)decodeWithPlainStr:(NSString *)plainStr font:(UIFont *)font textColor:(UIColor *)textColor{
    
    if (!plainStr) {return [[NSMutableAttributedString alloc]initWithString:@""];}else {
        _string    = plainStr;
        // 读取并加载对照表
        _emotionArray = [EmotionTool trafficSigns];
        //设置文本参数
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:4.0f];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:font forKey:NSFontAttributeName];
        [dict setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
        [dict setValue:textColor forKey:NSForegroundColorAttributeName];
        
        CGSize maxsize = CGSizeMake(1000, MAXFLOAT);
        _emotionSize = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        _attStr = [[NSMutableAttributedString alloc]initWithString:_string attributes:dict];
        
        [self executeMatch];
        
        [self setImageDataArray];
        
        NSMutableAttributedString *result = _attStr;
        
        for (int i = 0; i < _imageDataArray.count ; i ++) {
            
            NSRange range = [_imageDataArray[i][@"range"] rangeValue];
            
            NSDictionary *imageDic = [_imageDataArray objectAtIndex:i];
            
            Emotion *emotion = [imageDic objectForKey:@"emtion"];
            
            EmotionAttachment *attach = [[EmotionAttachment alloc] init];
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            
            [result replaceCharactersInRange:range withAttributedString:attachString];
            
            dict = nil;
        }
        _resultStr = result;
        
        return _resultStr;
    }
}

- (void)executeMatch {
    //比对结果
    NSString *regexString = checkStr;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSRange totalRange = NSMakeRange(0, [_string length]);
    
    _matches = [regex matchesInString:_string options:0 range:totalRange];
}

- (void)setImageDataArray {
    
    NSMutableArray *imageDataArray = [NSMutableArray array];
    //遍历结果
    for (int i = (int)_matches.count - 1; i >= 0; i --) {
        
        NSMutableDictionary *record = [NSMutableDictionary dictionary];
        
        EmotionAttachment *attachMent = [[EmotionAttachment alloc]init];
        
        attachMent.bounds = CGRectMake(0, -4, _emotionSize.height, _emotionSize.height);
        
        NSTextCheckingResult *match = [_matches objectAtIndex:i];
        
        NSRange matchRange = [match range];
        
        NSString *tagString = [_string substringWithRange:matchRange];
        
        for (Emotion *emtion in _emotionArray) {
            
            if ([emtion.chs isEqualToString:tagString]) {
                
                [record setObject:[NSValue valueWithRange:matchRange] forKey:@"range"];
                
                [record setObject:emtion forKey:@"emtion"];
                
                [imageDataArray addObject:record];
            }
        }
    }
    _imageDataArray = imageDataArray;
}
@end
