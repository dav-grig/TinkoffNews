//
//  TNNewsListTableViewCell.m
//  Tinkoff
//
//  Created by My City on 27.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsListTableViewCell.h"

@interface TNNewsListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *newslabel;

@end

@implementation TNNewsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)configureNewsWith:(NSString *)newsText {
    if (newsText.length && newsText != nil) {
        self.newslabel.text = [self removeHtmlCharacters:newsText];
    }
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

#pragma mark - Private
//TODO:- Need to improve
- (NSString *)removeHtmlCharacters:(NSString *)htmlString {
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<nobr>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</nobr>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&laquo;" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&raquo;" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"&mdash;" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<li>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</li>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<ul>" withString:@""];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"</ul>" withString:@""];
    return htmlString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
