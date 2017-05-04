//
//  Cake.m
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//

#import "Cake.h"
#import "NSURLSession+IgnoreErrors.h"
#import "acf_dispatch_main.h"

typedef void (^CakeImageDownloadBlock)(UIImage* _Nullable);


@interface Cake()
@property (nonatomic, strong, nonnull, readwrite) NSString* title;
@property (nonatomic, strong, nonnull, readwrite) NSString* details;
@property (nonatomic, strong, nonnull, readwrite) NSURL* imageURL;
@property (nonatomic, strong, nonnull, readwrite) UIImage* image;
@end

@implementation Cake

/// failable initialiser will return nil if the dictionary is not valid
- (nullable instancetype)initWithDictionary:(NSDictionary *_Nonnull)cakeDictionary {
    self = [super init];
    if( self ) {
        NSString* title = cakeDictionary[@"title"];
        NSString* details = cakeDictionary[@"desc"];
        NSString* imageURLString = cakeDictionary[@"image"];
        NSURL* imageURL = [NSURL URLWithString:imageURLString];
        if( title == nil || details == nil || imageURLString == nil || imageURL == nil ) {
            return nil;
        }
        
        self.title = title;
        self.details = details;
        self.imageURL = imageURL;
    }
    return self;
}

/// The supplied block may be called more than once if the image updates
/// if we have no image, send a placeholder and try to download
/// if we have an image, just send it.
- (void)provideImage:(nonnull CakeImageProviderBlock)provideImageBlock {
    if( self.image == nil ) {
        acf_dispatch_main(^{provideImageBlock(self, [UIImage imageNamed:@"default-placeholder"]);});
        [self downloadImageWithCompletion:^(UIImage * _Nullable image) {
            if( image != nil ) {
                self.image = image;
                acf_dispatch_main(^{provideImageBlock(self, self.image);});
            }
        }];
        return;
    }

    acf_dispatch_main(^{provideImageBlock(self, self.image);});
}

/// download the image and call the provide
- (void)downloadImageWithCompletion:(nonnull CakeImageDownloadBlock)imageBlock {
    NSURLSessionDataTask* task = [NSURLSession defaultDataTaskForURL:self.imageURL simpleCompletionBlock:^(NSData * _Nullable data) {
        UIImage* image = (data != nil) ? [UIImage imageWithData:data] : nil;
        imageBlock(image);
    }];
    [task resume];
}


@end
