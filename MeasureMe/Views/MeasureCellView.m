//
//  MeasureCellView.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-03-15.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "MeasureCellView.h"
#import "ApplicationStyle.h"
#import "NetworkMeasurementsClient.h"
#import <UIKitPlus/UIKitPlus.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface MeasureCellView ()
{
    CGFloat width, height;
    UILabel *label, *lengthLabel;
    CGFloat currentLengthValue;
}
@end

@implementation MeasureCellView

+ (instancetype) cellView
{
    MeasureCellView *view = [[MeasureCellView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle screenWidth], [ApplicationStyle screenHeight]- [ApplicationStyle navigationAndStatusBarHeight])];
    return view;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        width = frame.size.width; height = frame.size.height;
        [self buildUI];
    }
    return self;
}

- (void) buildUI
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle screenWidth], 0)];
    
    lengthLabel = [UILabel labelForString:@"0 mm"
                                     attributes:[NSAttributes attributesWithFontType:FontTypeRegular pointSize:18.0f andColor:[UIColor darkGrayTextColor]]
                                      yPosition:0
                                      xPosition:0
                                       maxWidth:400.0f];
    lengthLabel.textAlignment = NSTextAlignmentCenter;
    [lengthLabel fixHeight];
    [lengthLabel centerInWidth:[ApplicationStyle screenWidth]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.layer.cornerRadius = 50.0f;
    button.backgroundColor = [UIColor MeasureMeBlue];
    [button addTarget:self action:@selector(checkLength) forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds = YES;
    [button setTitle:@"Measure" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor]
                 forState:UIControlStateHighlighted];
    [button alignRightToXPosition:[ApplicationStyle screenWidth]/2 - 10.0f];
    [button setYPosition:lengthLabel.bottomOffset + 40.0f];

    
    UIButton *zeroButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    zeroButton.layer.cornerRadius = 50.0f;
    zeroButton.backgroundColor = [UIColor MeasureMeBlue];
    [zeroButton addTarget:self action:@selector(zeroLength) forControlEvents:UIControlEventTouchUpInside];
    zeroButton.clipsToBounds = YES;
    [zeroButton setTitle:@"Zero" forState:UIControlStateNormal];
    [zeroButton setTitleColor:[UIColor lightGrayColor]
                     forState:UIControlStateHighlighted];
    [zeroButton setXPosition:[ApplicationStyle screenWidth]/2 + 10.0f];
    [zeroButton setYPosition:button.topPosition];

    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    saveButton.tintColor = [UIColor MeasureMeBlue];
    [saveButton addTarget:self action:@selector(saveLengthTapped) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setYPosition:0];
    [saveButton alignRightToXPosition:zeroButton.center.x + saveButton.width/2.0f];
    [saveButton centerInHeight:lengthLabel.height forYOffset:lengthLabel.topPosition];
    
    [containerView setHeight:button.bottomOffset];

    [containerView addSubview:lengthLabel];
    [containerView addSubview:saveButton];
    [containerView addSubview:button];
    [containerView addSubview:zeroButton];
    [containerView centerInHeight:self.height - [ApplicationStyle navigationAndStatusBarHeight]];

    [self addSubview:containerView];
}

- (void) checkLength
{
    [SVProgressHUD show];
    [NetworkMeasurementsClient getInfoWithSuccess:^(CGFloat value) {
        [SVProgressHUD dismiss];
        CGFloat x = value*0.02785923753f;
        currentLengthValue = x;
        [self updateLengthLabel];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void) zeroLength
{
    [SVProgressHUD show];
    [NetworkMeasurementsClient postZeroValueWithSuccess:^{
        [SVProgressHUD dismiss];
        [self checkLength];
    } failure:^{
        [SVProgressHUD dismiss];
    }];
}

- (void) updateLengthLabel
{
    NSMutableAttributedString *lengthString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f mm", currentLengthValue] attributes:[NSAttributes attributesWithFontType:FontTypeRegular pointSize:18.0f andColor:[UIColor darkGrayTextColor]]];
    [lengthLabel setAttributedText:lengthString];
    [lengthLabel fixWidth];
}

- (void) saveLengthTapped
{
    if ([self.delegate respondsToSelector:@selector(saveLength:)]) {
        [self.delegate saveLength:currentLengthValue];
    }
}

@end
