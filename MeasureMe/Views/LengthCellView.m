//
//  LengthCellView.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-03-15.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "LengthCellView.h"
#import "ApplicationStyle.h"
#import <UIKitPlus/UIKitPlus.h>

@interface LengthCellView () <UITextFieldDelegate>
{
    CGFloat width, height;
    UILabel *lengthLabel;
    UITextField *description;
}
@end

@implementation LengthCellView

+ (instancetype) cellView
{
    LengthCellView *view = [[LengthCellView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle screenWidth], 40.0f)];
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
    description = [[UITextField alloc] initWithFrame:CGRectMake(15.0f, 0, 2.0f*[ApplicationStyle screenWidth]/3.0f, 20.0f)];
    description.font = [UIFont fontWithType:FontTypeRegular andSize:14.0f];
    description.textColor = [UIColor darkGrayTextColor];
    [description centerInHeight:height];
    description.delegate = self;
    description.placeholder = @"Enter a description";
    lengthLabel = [UILabel labelForString:@"0 mm"
                               attributes:[NSAttributes attributesWithFontType:FontTypeRegular pointSize:14.0f andColor:[UIColor darkGrayTextColor]]
                                yPosition:0
                                xPosition:0
                                 maxWidth:[ApplicationStyle screenWidth]/3.0f];
    lengthLabel.textAlignment = NSTextAlignmentRight;
    [lengthLabel alignRightToXPosition:width - 15.0f];
    [lengthLabel centerInHeight:40.0f];
    [self addSubview:description];
    [self addSubview:lengthLabel];
}

- (void) setLength:(CGFloat)length
{
    _length = length;
    if (length) {
        NSMutableAttributedString *lengthString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f mm", length] attributes:[NSAttributes attributesWithFontType:FontTypeRegular pointSize:14.0f andColor:[UIColor darkGrayTextColor]]];
        [lengthLabel setAttributedText:lengthString];
        [lengthLabel fixWidth];
    }
}

- (void) setDetails:(NSString *)details
{
    _details = details;
    [description setText:details];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(saveDescription:forObject:)]) {
        [self.delegate saveDescription:textField.text forObject:self];
    }
    [textField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
