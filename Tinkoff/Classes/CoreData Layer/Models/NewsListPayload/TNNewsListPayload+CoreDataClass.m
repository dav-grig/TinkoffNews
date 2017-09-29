//
//  TNNewsListPayload+CoreDataClass.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListPayload+CoreDataClass.h"
#import "TNNewsDeyailsPayload+CoreDataClass.h"
#import "TNCoreDataService.h"
#import "TNNewsList+CoreDataClass.h"

@implementation TNNewsListPayload
-(TNNewsListPayload *)initWithContext {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TNNewsListPayload" inManagedObjectContext:[TNCoreDataService sharedInstance].managedObjectContext];
    TNNewsListPayload *newsListPeyloadObject = [[TNNewsListPayload alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    [[TNCoreDataService sharedInstance].managedObjectContext insertObject:newsListPeyloadObject];
    return newsListPeyloadObject;
}
@end
