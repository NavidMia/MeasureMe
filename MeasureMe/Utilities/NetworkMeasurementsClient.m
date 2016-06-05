//
//  NetworkChampionsClient.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-11.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "NetworkMeasurementsClient.h"
#import "NetworkManager.h"
#import "AppConfiguration.h"

@implementation NetworkMeasurementsClient
+ (NSURLSessionDataTask *) getInfoWithSuccess:(void(^)(CGFloat value))successBlock
                                      failure:(void(^)(NSError *error))failureBlock
{
    NSURLSessionDataTask *task;
    task = [[NetworkManager manager] GET:@"https://api.particle.io/v1/devices/3c0029001047343339383037/value?access_token=0dd670e09bf53d980a5cda724738faa944231419" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (responseObject) {
            NSDictionary *responseObjectDictionary = [[NSDictionary alloc] initWithDictionary:responseObject];
            NSString *string = [NSString stringWithFormat:@"%@", responseObjectDictionary[@"result"]];
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            CGFloat value = [[numberFormatter numberFromString:string] floatValue];
//            value = value*0.024414f;
            successBlock(value);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    return task;
}

+ (NSURLSessionDataTask *) postZeroValueWithSuccess:(void(^)(void))successBlock
                                            failure:(void(^)(void))failureBlock
{
    NSURLSessionDataTask *task;
    task = [[NetworkManager manager] POST:@"https://api.particle.io/v1/devices/3c0029001047343339383037/zero?access_token=0dd670e09bf53d980a5cda724738faa944231419" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock();
    }];
    return task;
}
@end
