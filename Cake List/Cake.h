//
//  Cake.h
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//

@import UIKit;
@class Cake;

typedef void (^CakeImageProviderBlock)(Cake* _Nonnull, UIImage* _Nullable);

@interface Cake : NSObject
@property (nonatomic, strong, nonnull, readonly) NSString* title;
@property (nonatomic, strong, nonnull, readonly) NSString* details;

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nonnull)cakeDictionary;

/// The supplied block may be called more than once if the image is downloaded and updated
- (void)provideImage:(nonnull CakeImageProviderBlock)provideImageBlock;
@end
