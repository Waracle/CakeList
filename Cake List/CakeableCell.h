//
//  CakeableCell.h
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//

#import "Cake.h"
@protocol CakeableCell <NSObject>
- (void)populateWithCake:(nonnull Cake*)cake;
@end
