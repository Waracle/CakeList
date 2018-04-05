//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"
#import "Cake.h"

@interface CakeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cakeImageView;

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
    
    NSURL *url = [NSURL URLWithString:cake.imageURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self.cakeImageView setImage:image];
}

@end
