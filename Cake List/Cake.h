//
//  Cake.h
//  Cake List
//
//  Created by Daviner Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cake : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *detail;
@property (nonatomic, strong, readonly) NSString *imageURLString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
