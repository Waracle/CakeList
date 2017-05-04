//
//  CakeCell.h
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CakeableCell.h"

@interface CakeCell : UITableViewCell<CakeableCell>
@property (weak, nonatomic) IBOutlet UIImageView *cakeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
