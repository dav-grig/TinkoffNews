//
//  TNNewsDeyailsPayload+CoreDataProperties.h
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDeyailsPayload+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNNewsDeyailsPayload (CoreDataProperties)

+ (NSFetchRequest<TNNewsDeyailsPayload *> *)fetchRequest;

@property (nonatomic) int64_t creationDate;
@property (nonatomic) int64_t lastModificationDate;
@property (nullable, nonatomic, copy) NSString *content;
@property (nonatomic) int64_t bankInfoTypeId;
@property (nullable, nonatomic, copy) NSString *typeId;
@property (nullable, nonatomic, retain) TNNewsDetails *newsDetails;
@property (nullable, nonatomic, retain) TNNewsListPayload *title;

@end

NS_ASSUME_NONNULL_END
