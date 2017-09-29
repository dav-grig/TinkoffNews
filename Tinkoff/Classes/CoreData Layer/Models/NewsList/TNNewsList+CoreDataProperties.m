//
//  TNNewsList+CoreDataProperties.m
//  Tinkoff
//
//  Created by My City on 28.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsList+CoreDataProperties.h"

@implementation TNNewsList (CoreDataProperties)

+ (NSFetchRequest<TNNewsList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TNNewsList"];
}

@dynamic resultCode;
@dynamic trackingId;
@dynamic payload;

@end
