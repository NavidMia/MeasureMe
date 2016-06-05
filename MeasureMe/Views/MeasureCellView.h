//
//  MeasureCellView.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-03-15.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeasureCellViewDelegate <NSObject>

- (void) saveLength:(CGFloat) length;

@end

@interface MeasureCellView : UIView

@property (nonatomic, weak) id<MeasureCellViewDelegate> delegate;

+ (instancetype) cellView;

@end
