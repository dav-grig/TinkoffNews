//
//  TNNewsDeyailsPayload+CoreDataClass.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDeyailsPayload+CoreDataClass.h"
#import "TNNewsDetails+CoreDataClass.h"
#import "TNCoreDataService.h"
#import "TNNewsListPayload+CoreDataClass.h"

@implementation TNNewsDeyailsPayload
- (TNNewsDeyailsPayload *)initWithContext {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TNNewsDeyailsPayload" inManagedObjectContext:[TNCoreDataService sharedInstance].managedObjectContext];
    TNNewsDeyailsPayload *newsListObject = [[TNNewsDeyailsPayload alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    [[TNCoreDataService sharedInstance].managedObjectContext insertObject:newsListObject];
    return newsListObject;
}

@end
