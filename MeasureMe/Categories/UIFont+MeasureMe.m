//
//  UIFont+MeasureMe.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "UIFont+MeasureMe.h"
#import <UIKitPlus/UIKitPlus.h>

@implementation UIFont (MeasureMe)

static NSString *baseFontFamilyName = @"HelveticaNeue";

+ (CGFloat)largeTextSize
{
    return 17.0f;
}

+ (CGFloat)mediumTextSize
{
    return 15.0f;
}

+ (CGFloat)smallTextSize
{
    return 14.0f;
}

+ (NSString *)baseFontFamilyName
{
    return baseFontFamilyName;
}

+ (void)setBaseFontFamilyName:(NSString *)_baseFontFamilyName
{
    baseFontFamilyName = _baseFontFamilyName;
}

+ (NSString *)fontNameWithType:(FontType)fontType
{
    NSString *fontExtension = nil;
    switch(fontType)
    {
        case FontTypeLight:
        {
            fontExtension = @"Light";
            break;
        }
        case FontTypeUltraLight:
        {
            fontExtension = @"UltraLight";
            break;
        }
        case FontTypeMedium:
        {
            fontExtension = @"Medium";
            break;
        }
        case FontTypeBold:
        {
            fontExtension = @"Bold";
            break;
        }
        default:
        {
            fontExtension = @"";
            break;
        }
    }
    return [NSString stringWithFormat:@"%@%@%@", [self baseFontFamilyName], (fontExtension.length ? @"-" : @""), fontExtension];
}

+ (UIFont *)fontWithType:(FontType)fontType andSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:[self fontNameWithType:fontType] size:fontSize];
}

@end
