//
//  TNNewsListPayload+CoreDataProperties.h
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListPayload+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNNewsListPayload (CoreDataProperties)

+ (NSFetchRequest<TNNewsListPayload *> *)fetchRequest;

@property (nonatomic) int64_t bankInfoTypeId;
@property (nullable, nonatomic, copy) NSString *identifier;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *text;
@property (nonatomic) int64_t publicationDate;
@property (nullable, nonatomic, retain) TNNewsList *newsList;
@property (nullable, nonatomic, retain) TNNewsDeyailsPayload *newsDetailsPayload;

@end

NS_ASSUME_NONNULL_END
