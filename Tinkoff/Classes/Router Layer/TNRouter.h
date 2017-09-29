//
//  TNRouter.h
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TNNewsListPayload+CoreDataProperties.h"

@interface TNRouter : NSObject
// Navigate to news details page
- (void)showNewsDetailsFromSourceViewController:(UIViewController *)sourceViewController withNews:(TNNewsListPayload *)payload;

@end
