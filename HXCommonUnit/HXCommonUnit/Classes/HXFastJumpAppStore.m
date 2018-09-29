//
//  HXFastJumpAppStore.m
//  HXCommonUnit
//
//  Created by 杜红星 on 2018/9/29.
//  Copyright © 2018年 daojia. All rights reserved.
//

#import "HXFastJumpAppStore.h"

#define iOS_10_Later [[UIDevice currentDevice].systemVersion floatValue] >= 10

@interface HXFastJumpAppStore ()

@end

@implementation HXFastJumpAppStore

+ (instancetype)sharedInstance {
    static HXFastJumpAppStore *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc]init];
        }
    });
    return _instance;
}

- (void)jumpToAppStroeDetialPageWithAppId:(NSString *)appId {
    NSString *appUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",appId];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:appUrl]]) {
        if (iOS_10_Later) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appUrl] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appUrl]];
        }
    }
    
}

- (void)jumpToAppStroeSortOrderPageWithAppId:(NSString *)appId {
    NSString *appUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review",appId];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:appUrl]]) {
        if (iOS_10_Later) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appUrl] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appUrl]];
        }
    }
}

@end
