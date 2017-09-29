//
//  TNNewsDetailsMapping.h
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TNNewsDetailServiceSuccessBlock) (BOOL success);

@interface TNNewsDetailsMapping : NSObject
- (void)newsDetailsMapping:(NSDictionary *)news WithCompletionBlock:(TNNewsDetailServiceSuccessBlock)completionBlock;
@end
