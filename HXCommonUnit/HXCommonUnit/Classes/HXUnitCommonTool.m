//
//  HXUnitCommonTool.m
//  HXCommonUnit
//
//  Created by 杜红星 on 2018/9/29.
//  Copyright © 2018年 daojia. All rights reserved.
//

#import "HXUnitCommonTool.h"

@interface HXUnitCommonTool ()

@end

@implementation HXUnitCommonTool

+ (instancetype)sharedCommonTool {
    static HXUnitCommonTool *_commonTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_commonTool == nil) {
            _commonTool = [[self alloc]init];
        }
    });
    return _commonTool;
}

///iPhone X 系列
- (BOOL)isIPhoneXSeries
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight == 821.0f || screenHeight == 896.0f) {
        return YES;
    }
    return NO;
}

///iPhone X 系列
static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

@end
