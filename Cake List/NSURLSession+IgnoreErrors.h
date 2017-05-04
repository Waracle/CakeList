//
//  NSURLSession+IgnoreErrors.h
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//  Copyright © 2017 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLSession(IgnoreErrors)
+ (NSURLSessionDataTask* _Nonnull)defaultDataTaskForURL:(NSURL* _Nonnull)url simpleCompletionBlock:(void(^_Nonnull)(NSData* _Nullable data))completion;
@end
