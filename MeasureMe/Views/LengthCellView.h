//
//  LengthCellView.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-03-15.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LengthCellView;

@protocol LengthCellViewDelegate <NSObject>

- (void) saveDescription:(NSString *)description forObject:(LengthCellView *)cell;

@end

@interface LengthCellView : UIView

@property (nonatomic, assign) CGFloat length;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, weak) id<LengthCellViewDelegate> delegate;

+ (instancetype) cellView;

@end
