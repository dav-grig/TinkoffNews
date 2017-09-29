//
//  TNNewsDetails+CoreDataProperties.h
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetails+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TNNewsDetails (CoreDataProperties)

+ (NSFetchRequest<TNNewsDetails *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *resultCode;
@property (nullable, nonatomic, copy) NSString *trackingId;
@property (nullable, nonatomic, retain) TNNewsDeyailsPayload *payload;

@end

NS_ASSUME_NONNULL_END
