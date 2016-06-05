//
//  TableSectionHeaderView.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-03-15.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableSectionHeaderView : UIView

+ (TableSectionHeaderView *) headerViewWithTitle:(NSString *)title;

@property (nonatomic, strong) NSString *title;

@end
