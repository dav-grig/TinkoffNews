//
//  TNNewsListMapping.h
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TNNewsList;
typedef void (^TNServiceSuccessBlock) (BOOL success);


@interface TNNewsListMapping : NSObject

- (void)newsListMapping:(NSDictionary *)news WithCompletionBlock:(TNServiceSuccessBlock)completionBlock;

@end
