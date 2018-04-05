//
//  NetworkService.m
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "NetworkService.h"
#import "NSError+Extension.h"
#import "Cake.h"

@implementation NetworkService

- (void)fetchAllCakesWithCompletion:(FetchCakesCompletion)completion {
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf = self;
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            return [weakSelf requestCompletedWithCakes:nil error:error completion:completion];
            
        } else if (data && response) {
            
            return [weakSelf cakesRequestCompletedWithResponse:response data:data completion:completion];
        }
        
        NSError *unkownError = [NSError errorWithMessage:@"An unkown error occured. Please try again later."];
        [weakSelf requestCompletedWithCakes:nil error:unkownError completion:completion];
        
    }] resume] ;
}

- (void)cakesRequestCompletedWithResponse:(NSURLResponse *)response data:(NSData *)data completion:(FetchCakesCompletion)completion {
    
    NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
    BOOL isSuccessfulRequest = httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 400;
    
    if (!isSuccessfulRequest) {
        
        NSError *requestFailedError = [NSError errorWithMessage:@"The network request failed. Please try again later"];
        return [self requestCompletedWithCakes:nil error:requestFailedError completion:completion];
    }
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    
    if (jsonError) {
        
        return [self requestCompletedWithCakes:nil error:jsonError completion:completion];
    
    } else if ([responseData isKindOfClass:[NSArray class]]) {
        
        NSArray *cakesArray = (NSArray *)responseData;
        NSMutableArray *allCakes = [NSMutableArray new];
        
        for (NSDictionary *cakeDictionary in cakesArray) {
            
            Cake *cake = [[Cake alloc] initWithDictionary:cakeDictionary];
            [allCakes addObject:cake];
        }
        
        return [self requestCompletedWithCakes:allCakes error:nil completion:completion];
    }

    NSError *unkownResponseDataError = [NSError errorWithMessage:@"The server returned unexpected data. Please try again later."];
    [self requestCompletedWithCakes:nil error:unkownResponseDataError completion:completion];
}

- (void)requestCompletedWithCakes:(NSArray <Cake *>*)cakes error:(NSError *)error completion:(FetchCakesCompletion)completion {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        completion(cakes, error);
    });
}

@end
