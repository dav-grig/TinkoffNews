//
//  TNNewsListService.h
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TNServiceCompletionResponseBlock)(id result, NSError *error);
typedef void (^TNServiceCompletionBlock) (id result);
@class TNNewsListPayload;

@interface TNNewsListService : NSObject
//Downloads the data, does mapping and returns them while opening the page or refreshing it
- (void)obtainNewsListWithCompletionBlock:(TNServiceCompletionBlock)completionBlock;

//Loads the data from local DB while scrolling
- (void)fetchPayloadsListfromLocalDbWithOffset:(NSInteger)offset WithCompletionBlock:(TNServiceCompletionBlock)completionBlock;

@end
