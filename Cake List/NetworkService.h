//
//  NetworkService.h
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cake;
typedef void(^FetchCakesCompletion)(NSArray <Cake *>*cakes, NSError *fetchError);

@interface NetworkService : NSObject
                                
- (void)fetchAllCakesWithCompletion:(FetchCakesCompletion)completion;

@end
