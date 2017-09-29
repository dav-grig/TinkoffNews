//
//  TNNewsDetailService.h
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TNNewsDetailsServiceCompletionBlock) (id result);
typedef void (^TNNewsDetailsServiceCompletionResponseBlock)(id result, NSError *error);

@interface TNNewsDetailService : NSObject

// Loads the data from local DB. In case they absent,  downloads the data from server
- (void)obtainNewsListWithNewsId:(NSString *)newsId WithCompletionBlock:(TNNewsDetailsServiceCompletionBlock)completionBlock;

@end
