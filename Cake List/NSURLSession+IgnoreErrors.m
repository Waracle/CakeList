//
//  NSURLSession+IgnoreErrors.m
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//  Copyright © 2017 Stewart Hart. All rights reserved.
//

#import "NSURLSession+IgnoreErrors.h"

@implementation NSURLSession(IgnoreErrors)

/// ignore all errors and simply return the data, whether valid or not
+ (NSURLSessionDataTask* _Nonnull)defaultDataTaskForURL:(NSURL* _Nonnull)url
                                  simpleCompletionBlock:(void(^_Nonnull)(NSData* _Nullable data))completion {
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data);
    }];
    return task;
    
}

@end
