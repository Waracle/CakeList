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
#import <UIKit/UIKit.h>

typedef void(^FetchRequestCompletion)(id object, NSError *fetchError);

@interface NetworkService ()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation NetworkService

#pragma mark - Instantiation

+ (NetworkService *)sharedService {
    
    static NetworkService *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [NetworkService new];
        sharedInstance.session = [NSURLSession sharedSession];
    });
    
    return sharedInstance;
}

#pragma mark - Requests

- (void)fetchAllCakesWithCompletion:(FetchCakesCompletion)completion {
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    [self fetchDataWithURL:url isImageURL:false completion:completion];
}

- (void)fetchImageForURLCake:(Cake *)cake completoin:(FetchCakeImageCompletion)completion {
    
    NSURL *url = [NSURL URLWithString:cake.imageURLString];
    [self fetchDataWithURL:url isImageURL:true completion:completion];
}

- (void)fetchDataWithURL:(NSURL *)url isImageURL:(BOOL)isImageURL completion:(FetchRequestCompletion)completion {
    
    __weak typeof(self) weakSelf = self;
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            return [weakSelf requestCompletedWithCakes:nil error:error completion:completion];
            
        } else if (data && response) {
            
            return [weakSelf cakesRequestCompletedWithResponse:response data:data isImageURL:isImageURL completion:completion];
        }
        
        NSError *unkownError = [NSError errorWithMessage:@"An unkown error occured. Please try again later."];
        [weakSelf requestCompletedWithCakes:nil error:unkownError completion:completion];
        
    }] resume];
}

#pragma mark - Parsing

- (void)cakesRequestCompletedWithResponse:(NSURLResponse *)response data:(NSData *)data isImageURL:(BOOL)isImageURL completion:(FetchCakesCompletion)completion {
    
    NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
    BOOL isSuccessfulRequest = httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 400;
    
    if (!isSuccessfulRequest) {
        
        NSError *requestFailedError = [NSError errorWithMessage:@"The network request failed. Please try again later"];
        return [self requestCompletedWithCakes:nil error:requestFailedError completion:completion];
    }
    
    id object = nil;
    
    if (isImageURL) {
        
        object = [self imageForData:data];
        
    } else {
        
        NSError *jsonError;
        id responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonError) {
            
            return [self requestCompletedWithCakes:nil error:jsonError completion:completion];
        }
        
        object = [self cakesForData:responseData];
    }

    [self requestCompletedWithCakes:object error:nil completion:completion];
}

- (NSArray <Cake *>*)cakesForData:(NSData *)responseData {
    
    NSArray *cakesArray = (NSArray *)responseData;
    NSMutableArray *allCakes = [NSMutableArray new];
    
    for (NSDictionary *cakeDictionary in cakesArray) {
        
        Cake *cake = [[Cake alloc] initWithDictionary:cakeDictionary];
        [allCakes addObject:cake];
    }
    
    return allCakes;
}

- (UIImage *)imageForData:(NSData *)responseData {
    
    return [[UIImage alloc] initWithData:responseData];
}

- (void)requestCompletedWithCakes:(id)object error:(NSError *)error completion:(FetchRequestCompletion)completion {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        completion(object, error);
    });
}

@end
