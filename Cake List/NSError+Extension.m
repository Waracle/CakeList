//
//  NSError+Extension.m
//  Cake List
//
//  Created by Daviner Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "NSError+Extension.h"

@implementation NSError (Extension)

+ (NSError *)errorWithMessage:(NSString *)message {
    
    NSString *domain = [[NSBundle mainBundle] bundleIdentifier];
    NSError *error = [NSError errorWithDomain:domain code:-1000 userInfo:@{NSLocalizedDescriptionKey:message}];
    return error;
}

@end
