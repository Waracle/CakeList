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

@interface MasterViewController ()

@property (strong, nonatomic) NSArray <Cake *>*objects;

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Fetch

- (void)getData{
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:kNilOptions
                       error:&jsonError];
   
    if (jsonError) {
        
        // display error

    } else if ([responseData isKindOfClass:[NSArray class]]) {
        
        NSArray *cakesArray = (NSArray *)responseData;
        NSMutableArray *allCakes = [NSMutableArray new];
        
        for (NSDictionary *cakeDictionary in cakesArray) {
            
            Cake *cake = [[Cake alloc] initWithDictionary:cakeDictionary];
            [allCakes addObject:cake];
        }
        
        self.objects = allCakes.copy;
        [self.tableView reloadData];
            
    } else {
     
        
    }
}

@end
