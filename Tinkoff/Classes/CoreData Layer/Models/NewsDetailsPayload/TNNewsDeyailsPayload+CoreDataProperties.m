//
//  TNNewsDeyailsPayload+CoreDataProperties.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDeyailsPayload+CoreDataProperties.h"

@implementation TNNewsDeyailsPayload (CoreDataProperties)

+ (NSFetchRequest<TNNewsDeyailsPayload *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TNNewsDeyailsPayload"];
}

@dynamic creationDate;
@dynamic lastModificationDate;
@dynamic content;
@dynamic bankInfoTypeId;
@dynamic typeId;
@dynamic newsDetails;
@dynamic title;

@end
