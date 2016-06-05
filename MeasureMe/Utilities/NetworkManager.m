//
//  NetworkManager.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-11.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

#pragma mark - HTTP Methods

- (NSURLSessionDataTask *)GET:(NSString *)endPoint
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self setContentType];
    return [super GET:endPoint parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)endPoint
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self setContentType];
    return [super POST:endPoint parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PATCH:(NSString *)endPoint
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self setContentType];
    DDLogDebug(@"Request Parameters: %@", parameters);
    return [super PATCH:endPoint parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)endPoint
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self setContentType];
    return [super DELETE:endPoint parameters:parameters success:success failure:failure];
}

#pragma mark - Adding headers

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler
{
    NSMutableURLRequest *mRequest = request.mutableCopy;
    return [super dataTaskWithRequest:mRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError  *error) {
        if (!error) {
            completionHandler(response, responseObject, error);
        } else {
            NSString *errorMessage = nil;
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                errorMessage = responseObject[@"error_message"];
            }
            if (!errorMessage) {
                errorMessage = error.localizedDescription;
            }
            
            NSError *error = [NSError errorWithDomain:@"com.navidmia.MeasureMe" code:0 userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
            completionHandler(response, responseObject, error);
        }
    }];
}

- (BOOL)cancelTask:(NSURLSessionDataTask *)task
{
    if (task && task.state != NSURLSessionTaskStateCanceling && task.state != NSURLSessionTaskStateCompleted) {
        [task cancel];
        return YES;
    } else {
        return NO;
    }
}

- (void) setContentType
{
    self.requestSerializer = [AFJSONRequestSerializer serializer];
}

@end
