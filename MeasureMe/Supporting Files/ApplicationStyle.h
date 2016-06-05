//
//  ApplicationStyle.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+MeasureMe.h"
#import "UIColor+MeasureMe.h"

@interface ApplicationStyle : NSObject
#pragma mark - Initialization
+ (void) setup;
+ (void) styleNavigationBar;
+ (void) styleTabBar;
//+ (void) styleStatusBar;

#pragma mark - Sizes
+ (CGFloat) margin;
+ (CGFloat) marginSmall;
+ (CGFloat) marginMedium;
+ (CGFloat) marginLarge;
+ (CGFloat) tableViewSectionHeaderHeight;
+ (CGFloat) tableViewSectionFooterHeight;
+ (CGFloat) cellHeight;

#pragma mark - Global
+ (CGSize) screenSize;
+ (CGFloat) screenWidth;
+ (CGFloat) screenHeight;
+ (CGFloat) statusBarHeight;
+ (CGFloat)navigationAndStatusBarHeight;
+ (CGFloat)navigationBarHeight;
@end
