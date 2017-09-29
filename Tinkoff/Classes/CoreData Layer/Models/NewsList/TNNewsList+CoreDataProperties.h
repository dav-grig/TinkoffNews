//
//  TNNewsList+CoreDataProperties.h
//  Tinkoff
//
//  Created by My City on 28.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNNewsList (CoreDataProperties)

+ (NSFetchRequest<TNNewsList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *resultCode;
@property (nullable, nonatomic, copy) NSString *trackingId;
@property (nullable, nonatomic, retain) NSSet<TNNewsListPayload *> *payload;

@end

@interface TNNewsList (CoreDataGeneratedAccessors)

- (void)addPayloadObject:(TNNewsListPayload *)value;
- (void)removePayloadObject:(TNNewsListPayload *)value;
- (void)addPayload:(NSSet<TNNewsListPayload *> *)values;
- (void)removePayload:(NSSet<TNNewsListPayload *> *)values;

@end

NS_ASSUME_NONNULL_END
