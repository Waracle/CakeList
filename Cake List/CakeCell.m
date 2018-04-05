//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"
#import "Cake.h"
#import "NetworkService.h"

@interface CakeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cakeImageView;

@property (strong, nonatomic) IBOutlet NetworkService *networkService;

@end

@implementation CakeCell

#pragma mark - Lifecycle

- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.cakeImageView.image = nil;
    self.titleLabel.text = nil;
    self.descriptionLabel.text = nil;
}

#pragma mark - Configuration

- (void)configureWithCake:(Cake *)cake {
    
    self.titleLabel.text = cake.title;
    self.descriptionLabel.text = cake.detail;
    
    [self fetchCakeImageForCake:cake];
}

#pragma mark - Image fetch

- (void)fetchCakeImageForCake:(Cake *)cake {
    
    self.networkService = [NetworkService sharedService];
    __weak typeof(self) weakSelf = self;
    
    [self.networkService fetchImageForURLCake:cake completoin:^(UIImage *cakeImage, NSError *fetchError) {
    
        [weakSelf.cakeImageView setImage:cakeImage];
    }];
}

@end
