//
//  TNNewsListTableViewCell.h
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNNewsListTableViewCell : UITableViewCell

+ (NSString *)className;

- (void)configureNewsWith:(NSString *)newsText;
@end
