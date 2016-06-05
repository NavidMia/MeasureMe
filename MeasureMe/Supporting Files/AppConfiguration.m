//
//  AppConfiguration.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "AppConfiguration.h"

@implementation AppConfiguration

static NSDictionary *settingsDictionary;

+ (void) initialize
{
    [self loadConfiguration];
}

+ (void) loadConfiguration
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"app_configuration" ofType:@"json"];
    NSData* dictionaryData = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    settingsDictionary = [NSJSONSerialization JSONObjectWithData:dictionaryData
                                                         options:kNilOptions error:&error];
    if (error && !settingsDictionary) {
        DDLogError(@"Error: Failed to load messaging configuration: %@", [error localizedDescription]);
    }
}

+ (NSDictionary *) settingsDictionary
{
    return settingsDictionary;
}

#pragma mark - API Keys
+ (NSString *) riotApiKey
{
    return settingsDictionary[@"riot_application_key"];
}

@end
