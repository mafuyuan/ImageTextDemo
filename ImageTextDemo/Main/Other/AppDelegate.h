//
//  AppDelegate.h
//  ImageTextDemo
//
//  Created by Justec_Mac on 2018/5/23.
//  Copyright © 2018年 JustecMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

