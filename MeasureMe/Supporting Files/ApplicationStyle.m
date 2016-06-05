//
//  ApplicationStyle.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "ApplicationStyle.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <UIKitPlus/UIKitPlus.h>

@implementation ApplicationStyle
#pragma mark - Initialization
+ (void) setup
{
//    [self styleStatusBar];
    [self styleNavigationBar];
    [self styleTabBar];
}

+ (void) styleNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor MeasureMeBlue]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:[UIFont mediumTextSize]],
                                                           }];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:[UIFont largeTextSize]],
                                                           }
                                                forState:UIControlStateNormal];
}

+ (void) styleTabBar
{
    [[UITabBar appearance] setTintColor:[UIColor MeasureMeBlue]];
}

//+ (void) styleStatusBar
//{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//}

+ (void) styleProgressHUD
{
    [SVProgressHUD setForegroundColor:[UIColor MeasureMeBlue]];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0.0f, [ApplicationStyle navigationAndStatusBarHeight])];
}

#pragma mark - Sizes
+ (CGFloat) margin
{
    return 15.0f;
}

+ (CGFloat) marginMedium
{
    return 10.0f;
}

+ (CGFloat) marginSmall
{
    return 6.5f;
}

+ (CGFloat) marginLarge
{
    return 20.0f;
}

+ (CGFloat) tableViewSectionHeaderHeight
{
    return 30.0f;
}

+ (CGFloat) tableViewSectionFooterHeight
{
    return 13.0f;
}

+ (CGFloat) cellHeight
{
    return 100.0f;
}

#pragma mark - Global
+ (CGSize) screenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat) screenWidth
{
    return [ApplicationStyle screenSize].width;
}

+ (CGFloat) screenHeight
{
    return [ApplicationStyle screenSize].height;
}

+ (CGFloat) statusBarHeight
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)navigationAndStatusBarHeight
{
    return ([(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.navigationController navigationBar].bottomOffset ? : 64.0f);
}

+ (CGFloat)navigationBarHeight
{
    return ([(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.navigationController navigationBar].height ? : 40.0f);
}

@end
