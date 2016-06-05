//
//  AppConfiguration.h
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfiguration : NSObject

+ (NSDictionary *) settingsDictionary;

#pragma mark - API Keys
+ (NSString *) riotApiKey;

@end
