//
//  ComposeToolBar.h
//  SDisplay_IOS
//
//  Created by 佳思德Mac on 2016/12/30.
//  Copyright © 2016年 佳思德Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComposeToolBar;

@protocol ComposeToolbarDelegate <NSObject>

@optional

- (void)composeTool:(ComposeToolBar *)toolbar;

@end

@interface ComposeToolBar : UIView

@property (nonatomic, weak) id<ComposeToolbarDelegate> delegate;

@property (nonatomic ,weak)UIButton *button;

@end
