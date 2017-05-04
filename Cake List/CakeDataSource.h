//
//  CakeDataSource.h
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//

@import UIKit;

@interface CakeDataSource : NSObject<UITableViewDataSource>
- (nonnull instancetype)initWithCellIdentifier:(nonnull NSString*)cellIdentifier;
- (void)updateCakesWithCompletion:(nullable dispatch_block_t)completion;
@end
