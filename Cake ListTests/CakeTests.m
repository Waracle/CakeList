//
//  CakeTests.m
//  Cake List
//
//  Created by Alan Francis on 04/05/2017.
//  Copyright © 2017 Stewart Hart. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Cake.h"

@interface CakeTests : XCTestCase
@end

@implementation CakeTests

- (void)testGood {
    NSDictionary* test = @{@"title":@"a title", @"desc":@"a description", @"image":@"http://foo.com/image.jpg"};
    Cake* cake = [[Cake alloc] initWithDictionary:test];
    XCTAssertNotNil(cake);
    XCTAssertEqual(@"a title", cake.title);
    XCTAssertEqual(@"a description", cake.details);
    // ObjC lets us access the private methods \o/
    XCTAssertEqual(@"http://foo.com/image.jpg", [[cake valueForKey:@"imageURL"] absoluteString]);
}

- (void)testNoTitle {
    NSDictionary* test = @{@"NO_TITLE_HERE":@"a title", @"desc":@"a description", @"image":@"http://foo.com/image.jpg"};
    Cake* cake = [[Cake alloc] initWithDictionary:test];
    XCTAssertNil(cake);
}

- (void)testNoDesc {
    NSDictionary* test = @{@"title":@"a title", @"NO_DESC_HERE":@"a description", @"image":@"http://foo.com/image.jpg"};
    Cake* cake = [[Cake alloc] initWithDictionary:test];
    XCTAssertNil(cake);
}

- (void)testNoImage {
    NSDictionary* test = @{@"title":@"a title", @"NO_DESC_HERE":@"a description", @"NO_IMAGE_HERE":@"http://foo.com/image.jpg"};
    Cake* cake = [[Cake alloc] initWithDictionary:test];
    XCTAssertNil(cake);
}

- (void)testBadImageURL {
    NSDictionary* test = @{@"title":@"a title", @"NO_DESC_HERE":@"a description", @"image":@"NOT_A_URL"};
    Cake* cake = [[Cake alloc] initWithDictionary:test];
    XCTAssertNil(cake);
}

@end
