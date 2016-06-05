//
//  NetworkMeasurementsClient.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-11.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkMeasurementsClient : NSObject
+ (NSURLSessionDataTask *) getInfoWithSuccess:(void(^)(CGFloat value))successBlock
                                      failure:(void(^)(NSError *error))failureBlock;

+ (NSURLSessionDataTask *) postZeroValueWithSuccess:(void(^)(void))successBlock
                                            failure:(void(^)(void))failureBlock;

@end
