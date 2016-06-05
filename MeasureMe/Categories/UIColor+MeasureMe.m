//
//  UIColor+MeasureMe.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "UIColor+MeasureMe.h"

@implementation UIColor (MeasureMe)

#define COLOR_VALUE_MAX 255.0f

#define RGBValue(x) (x/COLOR_VALUE_MAX)

+ (UIColor *)color256WithRed:(CGFloat)redValue green:(CGFloat)greenValue blue:(CGFloat)blueValue
{
    return [self color256WithRed:redValue green:greenValue blue:blueValue alpha:COLOR_VALUE_MAX];
}

+ (UIColor *)color256WithRed:(CGFloat)redValue green:(CGFloat)greenValue blue:(CGFloat)blueValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:RGBValue(redValue)
                           green:RGBValue(greenValue)
                            blue:RGBValue(blueValue)
                           alpha:RGBValue(alphaValue)];
}

+ (UIColor *)color256WithWhite:(CGFloat)whiteValue
{
    return [self color256WithWhite:whiteValue alpha:COLOR_VALUE_MAX];
}

+ (UIColor *)color256WithWhite:(CGFloat)whiteValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithWhite:RGBValue(whiteValue)
                             alpha:RGBValue(alphaValue)];
}

+ (UIColor *)MeasureMeBlue
{
    return [UIColor color256WithRed:25.0f green:215.0f blue:215.0f];
}

+ (UIColor *)lightGrayBackgroundColor
{
    return [UIColor color256WithWhite:241.0f];
}

+ (UIColor *)darkGrayTextColor
{
    return [UIColor color256WithWhite:96.0f];
}
@end
