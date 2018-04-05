//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "Cake.h"
#import "NetworkService.h"

@interface MasterViewController ()

@property (strong, nonatomic) NSArray <Cake *>*objects;
@property (strong, nonatomic) NetworkService *networkService;

@end

@implementation MasterViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self getData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    Cake *cake = self.objects[indexPath.row];
    [cell configureWithCake:cake];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fetch

- (void)getData{
    
    self.networkService = [NetworkService new];
    __weak typeof(self) weakSelf = self;
    
    [self.networkService fetchAllCakesWithCompletion:^(NSArray<Cake *> *cakes, NSError *fetchError) {
        
        if (fetchError) {
            
        } else {
            
            weakSelf.objects = cakes;
            [weakSelf.tableView reloadData];
        }
    }];
}

@end
