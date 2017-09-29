//
//  TNNewsList+CoreDataClass.h
//  Tinkoff
//
//  Created by My City on 28.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TNNewsListPayload;

NS_ASSUME_NONNULL_BEGIN

@interface TNNewsList : NSManagedObject
- (TNNewsList *)initWithContext;
@end

NS_ASSUME_NONNULL_END

#import "TNNewsList+CoreDataProperties.h"
