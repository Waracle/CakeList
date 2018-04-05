//
//  NetworkService.h
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cake;
@class UIImage;

typedef void(^FetchCakesCompletion)(NSArray <Cake *>*cakes, NSError *fetchError);
typedef void(^FetchCakeImageCompletion)(UIImage *cakeImage, NSError *fetchError);

@interface NetworkService : NSObject

+ (NetworkService *)sharedService;

- (void)fetchAllCakesWithCompletion:(FetchCakesCompletion)completion;
- (void)fetchImageForURLCake:(Cake *)cake completoin:(FetchCakeImageCompletion)completion;

@end
