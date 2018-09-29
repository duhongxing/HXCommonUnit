//
//  HXFastJumpAppStore.h
//  HXCommonUnit
//
//  Created by 杜红星 on 2018/9/29.
//  Copyright © 2018年 daojia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXFastJumpAppStore : NSObject

+ (instancetype)sharedInstance;

/**
 跳转到AppStore 应用详情页
 
 @param appId 应用id
 */
- (void)jumpToAppStroeDetialPageWithAppId:(NSString *)appId;

/**
 跳转到AppStore 撰写评价页
 
 @param appId 应用id
 */
- (void)jumpToAppStroeSortOrderPageWithAppId:(NSString *)appId;


@end
