//
//  TNNewsListTableViewCell.m
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListTableViewCell.h"

@interface TNNewsListTableViewCell()

@end

@implementation TNNewsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

+ (CGFloat)cellRowHeight {
    return 150;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
