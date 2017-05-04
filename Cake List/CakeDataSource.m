//
//  CakeDataSource.m
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//

#import "CakeDataSource.h"
#import "CakeableCell.h"
#import "NSURLSession+IgnoreErrors.h"
#import "acf_dispatch_main.h"

NSString* const kURLString = @"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json";

@interface CakeDataSource()
@property (nonatomic, strong, nonnull) NSArray<Cake*>* items;
@property (nonatomic, strong, nonnull) NSString* cellIdentifier;
@end

@implementation CakeDataSource

- (instancetype)initWithCellIdentifier:( NSString* _Nonnull )cellIdentifier {
    self = [super init];
    if( self ) {
        self.items = [NSMutableArray array];
        self.cellIdentifier = cellIdentifier;
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<CakeableCell>* cell = (UITableViewCell<CakeableCell>*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    [cell populateWithCake:self.items[indexPath.row]];
    
    return cell;
}

#pragma mark - Private
- (void)updateCakesWithCompletion:(dispatch_block_t)completion {
    NSURLSessionDataTask* task = [NSURLSession defaultDataTaskForURL:[NSURL URLWithString:kURLString]
                                               simpleCompletionBlock:^(NSData * _Nullable data) {
                                                   [self parseNetworkData:data];
                                                   acf_dispatch_main(completion);
                                               }];
    [task resume];
}

- (void)parseNetworkData:(NSData* _Nullable)data {
    if( data != nil ) {
           NSArray* items = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:NULL];
           self.items = [self parseJsonData:items];
    }
}

- (NSArray<Cake*>*)parseJsonData:(NSArray*)items {
    NSMutableArray<Cake*>* result = [NSMutableArray array];
    if( items ) {
        for (NSDictionary* cakeDic in items) {
            Cake* cake = [[Cake alloc] initWithDictionary:cakeDic];
            if( cake ) {
                [result addObject:cake];
            }
        }
    }
    return result;
}

@end
