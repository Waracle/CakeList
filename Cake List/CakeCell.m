//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"

@interface CakeCell()
@property( nonatomic, weak, nullable) Cake* cake;
@end
@implementation CakeCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.cake = nil;
    self.cakeImageView.image = nil;
    self.titleLabel.text = @"";
    self.descriptionLabel.text = @"";
}

- (void)populateWithCake:(Cake *)cake {
    self.cake = cake;
    self.titleLabel.text = cake.title;
    self.descriptionLabel.text = cake.details;
    [cake provideImage:^(Cake* _Nonnull cake, UIImage* _Nullable image) {
        // check we havent changed the cake in the meantime
        // bit inefficient, but much simpler than tracking all the
        // image download operatiosn to make them cancellable
        if( cake == self.cake ) {
            self.cakeImageView.image = image;
        }
    }];
}
@end
