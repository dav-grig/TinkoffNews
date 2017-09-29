//
//  TNNewsDetails+CoreDataProperties.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetails+CoreDataProperties.h"

@implementation TNNewsDetails (CoreDataProperties)

+ (NSFetchRequest<TNNewsDetails *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TNNewsDetails"];
}

@dynamic resultCode;
@dynamic trackingId;
@dynamic payload;

@end
