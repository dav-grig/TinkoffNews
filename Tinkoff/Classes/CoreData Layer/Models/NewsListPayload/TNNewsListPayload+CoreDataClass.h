//
//  TNNewsListPayload+CoreDataClass.h
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TNNewsDeyailsPayload, TNNewsList;

NS_ASSUME_NONNULL_BEGIN

@interface TNNewsListPayload : NSManagedObject
-(TNNewsListPayload *)initWithContext;
@end

NS_ASSUME_NONNULL_END

#import "TNNewsListPayload+CoreDataProperties.h"
