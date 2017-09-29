//
//  TNNewsDetails+CoreDataClass.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetails+CoreDataClass.h"
#import "TNNewsDeyailsPayload+CoreDataClass.h"
#import "TNCoreDataService.h"

@implementation TNNewsDetails
- (TNNewsDetails *)initWithContext {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TNNewsDetails" inManagedObjectContext:[TNCoreDataService sharedInstance].managedObjectContext];
    TNNewsDetails *newsListObject = [[TNNewsDetails alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    [[TNCoreDataService sharedInstance].managedObjectContext insertObject:newsListObject];
    return newsListObject;
}
@end
