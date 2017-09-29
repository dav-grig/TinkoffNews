//
//  TNNewsListPayload+CoreDataProperties.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListPayload+CoreDataProperties.h"

@implementation TNNewsListPayload (CoreDataProperties)

+ (NSFetchRequest<TNNewsListPayload *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TNNewsListPayload"];
}

@dynamic bankInfoTypeId;
@dynamic identifier;
@dynamic name;
@dynamic text;
@dynamic publicationDate;
@dynamic newsList;
@dynamic newsDetailsPayload;

@end
