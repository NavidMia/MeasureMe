//
//  TableSectionHeaderView.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-03-15.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "TableSectionHeaderView.h"
#import "ApplicationStyle.h"
#import <UIKitPlus/UIKitPlus.h>

@interface TableSectionHeaderView ()
{
    CGFloat width, height;
    UILabel *titleLabel;
    UIView *separatorView;
}
@end

@implementation TableSectionHeaderView

+ (TableSectionHeaderView *) headerViewWithTitle:(NSString *)title
{
    TableSectionHeaderView *headerView = [[TableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle screenWidth], 50.0f)
                                                                                 title:title];
    return headerView;
}

- (instancetype) initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        width = frame.size.width;
        height = frame.size.height;

        self.title = title;
        [self buildUI];
    }
    return self;
}

- (void) buildUI
{
    CGFloat margin = [ApplicationStyle margin];
    self.backgroundColor = [UIColor whiteColor];
    titleLabel = [UILabel labelForString:self.title
                              attributes:[NSAttributes attributesWithFontType:FontTypeMedium pointSize:[UIFont largeTextSize] andColor:[UIColor darkGrayTextColor]]
                               yPosition:0.0f
                               xPosition:margin
                                maxWidth:width-margin *2.0f];
    [titleLabel alignBottomToYPosition:height - 5.0f];
    [titleLabel setWidth:width - margin *2.0f];

    separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, height-0.5f, width, 0.5f)];
    separatorView.backgroundColor = [UIColor lightGrayBackgroundColor];
    [self addSubview:separatorView];
    [self addSubview:titleLabel];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [titleLabel setText:_title];
}

@end
