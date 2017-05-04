//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "CakeDataSource.h"

@interface MasterViewController ()
@property (nonatomic, strong, nullable) CakeDataSource* cakeDataSource;
@property (strong, nonatomic) NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.cakeDataSource = [[CakeDataSource alloc] initWithCellIdentifier:@"CakeCell"];
    self.tableView.dataSource = self.cakeDataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.cakeDataSource updateCakesWithCompletion:^{
        [self.tableView reloadData];
    }];
}

/// invoked by the refreshControl on pull-to-refresh
- (IBAction)refreshItems:(id)sender {
    [self.cakeDataSource updateCakesWithCompletion:^{
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

@end
