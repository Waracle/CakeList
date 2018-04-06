//
//  Cake.m
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "Cake.h"
#import "Cake_List-Swift.h"

@implementation Cake

@dynamic description;

#pragma mark - Instantiation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        _title = dictionary[@"title"];
        _detail = dictionary[@"desc"];
        _imageURLString = dictionary[@"image"];
    }
    
    return self;
}

@end
