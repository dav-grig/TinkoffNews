//
//  TNNewsDetailsViewController.m
//  Tinkoff
//
//  Created by My City on 29.09.17.
//  Copyright © 2017 tinkoff. All rights reserved.
//

#import "TNNewsDetailsViewController.h"
#import "TNNewsDetailService.h"
#import <SafariServices/SafariServices.h>

@interface TNNewsDetailsViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *newsTextView;
@property (strong, nonatomic) TNNewsDetailService *newsDetailService;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TNNewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.newsDetailService = [TNNewsDetailService new];
    [self configureAppearance];
    [self loadServiceData];
}

- (void)configureAppearance {
    self.newsTextView.textContainer.lineFragmentPadding = 0;
    self.newsTextView.textContainerInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([URL.absoluteString hasPrefix:@"http"] || [[URL absoluteString] hasPrefix:@"https"]) {
        
        NSString *urlSting = [NSString stringWithFormat:@"%@", URL];
        urlSting = [urlSting stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlSting];
        
        if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_9_0) {
            SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:url];
            [self presentViewController:safariController animated:YES completion:nil];
        }
        else {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        return NO;
    }
    
    return YES;
}

#pragma mark - Services

- (void)loadServiceData {
    [self.activityIndicator startAnimating];
    typeof(self) __weak weakSelf = self;
    [self.newsDetailService obtainNewsListWithNewsId:self.newsId WithCompletionBlock:^(id result) {
        NSString *contentString = result;
        contentString = [weakSelf removeHtmlCharacters:contentString];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.newsTextView.text = contentString;
                [weakSelf.activityIndicator stopAnimating];
            });
    }];
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

@end
