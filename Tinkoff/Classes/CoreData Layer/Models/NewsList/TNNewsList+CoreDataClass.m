//
//  TNNewsList+CoreDataClass.m
//  Tinkoff
//
//  Created by My City on 28.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsList+CoreDataClass.h"
#import "TNNewsListPayload+CoreDataClass.h"
#import "TNCoreDataService.h"

@implementation TNNewsList
- (TNNewsList *)initWithContext {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TNNewsList" inManagedObjectContext:[TNCoreDataService sharedInstance].managedObjectContext];
    TNNewsList *newsListObject = [[TNNewsList alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    [[TNCoreDataService sharedInstance].managedObjectContext insertObject:newsListObject];
    return newsListObject;
}

@end
