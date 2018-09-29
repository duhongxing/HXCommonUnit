//
//  ViewController.m
//  HXCommonUnit
//
//  Created by 杜红星 on 2018/9/26.
//  Copyright © 2018年 daojia. All rights reserved.
//

#import "ViewController.h"
#import "HXCommonUnit.h"
#import "HXUnitCommonTool.h"
#import <StoreKit/StoreKit.h>

#define AppId @"897342825"

@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - AppStore

- (void)showAppStoreReviewId:(NSString *)appId
{
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc]init];
    storeProductVC.delegate = self;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (!error) {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}


//评价完成
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Review

- (void)addAppReviewWithAppId:(NSString *)appId{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"亲喜欢**APP么?给个五星好评吧!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //跳转APPStore 中应用的撰写评价页面
    UIAlertAction *review = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *appReviewUrl = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",appId]];
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            [[UIApplication sharedApplication] openURL:appReviewUrl options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:appReviewUrl];
        }
    }];
    
    //不做任何操作
    UIAlertAction *noReview = [UIAlertAction actionWithTitle:@"用用再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVC removeFromParentViewController];
    }];
    
    [alertVC addAction:review];
    [alertVC addAction:noReview];
    //判断系统,是否添加五星好评的入口
    if (@available(iOS 10.3, *)) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
            UIAlertAction *fiveStar = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication].keyWindow endEditing:YES];
                //  五星好评
                [SKStoreReviewController requestReview];
            }];
            [alertVC addAction:fiveStar];
        }
    } else {
        // Fallback on earlier versions
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[[UIApplication sharedApplication]keyWindow] rootViewController] presentViewController:alertVC animated:YES completion:nil];
    });
}



@end
